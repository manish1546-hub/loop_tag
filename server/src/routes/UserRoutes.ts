import express from "express";
import { loginUser, registerUser, currentUser } from "../controllers/UserController";
import { authenticateAdminJWT, authenticateJWT } from "../middleware/authMiddleware";

const router = express.Router();

router.route("/current").get(authenticateJWT, currentUser);
router.route("/current/admin").get(authenticateAdminJWT, currentUser);
router.route("/login").post(loginUser);
router.route("/register").post(registerUser);

export default router;
