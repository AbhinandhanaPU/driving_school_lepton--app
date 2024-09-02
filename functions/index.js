/* eslint-disable no-unused-vars */
/* eslint-disable max-len */
/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onDocumentUpdated} = require("firebase-functions/v2/firestore");

const functions = require("firebase-functions/v1");

const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();
const {GoogleAuth} = require("google-auth-library");
const path = require("path");
require("dotenv").config();
const serviceAccountPath = process.env.GOOGLE_APPLICATION_CREDENTIALS;
// const serviceAccountPath = process.env.GOOGLE_APPLICATION_CREDENTIALS "const serviceAccountPath = process.env.GOOGLE_APPLICATION_CREDENTIALS;"
if (!serviceAccountPath) {
  throw new Error("he GOOGLE_APPLICATION_CREDENTIALS environment variable is not set.");
}
const serviceAccount = require("./service-account-key.json");
// Load your service account key JSON file


const getAccessTokens = async () => {
  try {
    const auth = new GoogleAuth({
      credentials: serviceAccount,
      scopes: ["https://www.googleapis.com/auth/cloud-platform", "https://www.googleapis.com/auth/datastore"],
    });
    const client = await auth.getClient();
    const tokenResponse = await client.getAccessToken();
    const accessToken = tokenResponse.token;
    if (!accessToken) {
      throw new Error("Access token is undefined");
    }
    await db.collection("PushNotification").doc("key").update({key: accessToken});
    console.log(`Access token saved to Firestore: ${accessToken}`);
    return accessToken;
  } catch (error) {
    console.error("Error fetching access token:", error);
    throw error;
  }
};

exports.getPushnotificationServerKey = functions.pubsub.schedule("every 15 minutes")
    .onRun(async (context) => {
      try {
        const accessToken = await getAccessTokens();
        console.log(`Access token retrieved: ${accessToken}`);
      } catch (error) {
        console.error("Error in getPushnotificationServerKey function:", error);
      }
    });


