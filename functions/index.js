const functions = require("firebase-functions");
const admin = require("firebase-admin");
const stripe = require("stripe")(functions.config().stripe.secret);

admin.initializeApp();

exports.createCheckoutSession = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "The function must be called while authenticated."
    );
  }

  const { amount, providerId } = data;
  const uid = context.auth.uid;

  // In a real application, you would use the providerId to select the correct payment gateway.
  // For this example, we will hardcode Stripe.
  if (providerId !== "stripe") {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Invalid payment provider."
    );
  }

  const session = await stripe.checkout.sessions.create({
    payment_method_types: ["card"],
    line_items: [
      {
        price_data: {
          currency: "usd",
          product_data: {
            name: "Deposit",
          },
          unit_amount: amount * 100, // Stripe expects the amount in cents
        },
        quantity: 1,
      },
    ],
    mode: "payment",
    success_url: "https://your-app.com/success", // Replace with your success URL
    cancel_url: "https://your-app.com/cancel", // Replace with your cancel URL
    client_reference_id: uid,
  });

  return { url: session.url };
});

exports.paymentWebhook = functions.https.onRequest(async (req, res) => {
  const sig = req.headers["stripe-signature"];
  const endpointSecret = functions.config().stripe.webhook_secret;

  let event;

  try {
    event = stripe.webhooks.constructEvent(req.rawBody, sig, endpointSecret);
  } catch (err) {
    console.log(`⚠️  Webhook signature verification failed.`, err.message);
    return res.sendStatus(400);
  }

  // Handle the event
  if (event.type === "checkout.session.completed") {
    const session = event.data.object;
    const uid = session.client_reference_id;
    const amount = session.amount_total / 100; // Convert from cents to dollars

    const userRef = admin.firestore().collection("users").doc(uid);
    const depositRef = admin.firestore().collection("deposits").doc();

    await admin.firestore().runTransaction(async (transaction) => {
      const userDoc = await transaction.get(userRef);
      const newBalance = (userDoc.data().liveBalance || 0) + amount;

      transaction.update(userRef, { liveBalance: newBalance });
      transaction.set(depositRef, {
        userId: uid,
        amount: amount,
        status: "completed",
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });
  }

  res.json({ received: true });
});
