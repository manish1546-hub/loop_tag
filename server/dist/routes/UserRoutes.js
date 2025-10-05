"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const UserController_1 = require("../controllers/UserController");
const authMiddleware_1 = require("../middleware/authMiddleware");
const router = express_1.default.Router();
router.route("/current").get(authMiddleware_1.authenticateJWT, UserController_1.currentUser);
router.route("/current/admin").get(authMiddleware_1.authenticateAdminJWT, UserController_1.currentUser);
router.route("/login").post(UserController_1.loginUser);
router.route("/register").post(UserController_1.registerUser);
exports.default = router;
//# sourceMappingURL=UserRoutes.js.map