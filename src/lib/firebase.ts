import { initializeApp, getApps } from "firebase/app";
import { getStorage } from "firebase/storage";

// Public web config for the existing bdc-website-2 app.
const firebaseConfig = {
  apiKey: "AIzaSyAYQBTSh_EBT3VGsvajSkE6nbexmDS082w",
  authDomain: "bdc-website-2.firebaseapp.com",
  projectId: "bdc-website-2",
  storageBucket: "bdc-website-2.appspot.com",
  messagingSenderId: "30721627721",
  appId: "1:30721627721:web:f03a62c55629760ec19198",
  measurementId: "G-V2TLJ9BK5W",
};

export const firebaseApp = getApps()[0] ?? initializeApp(firebaseConfig);
export const storage = getStorage(firebaseApp);

const bucket = firebaseConfig.storageBucket;

export function storageImage(publicPath: string) {
  const objectPath = `next-site${publicPath.startsWith("/") ? publicPath : `/${publicPath}`}`;
  return `https://firebasestorage.googleapis.com/v0/b/${bucket}/o/${encodeURIComponent(objectPath)}?alt=media`;
}
