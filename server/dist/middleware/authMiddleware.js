"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.authenticateAdminJWT = exports.authenticateJWT = void 0;
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const authenticateJWT = (req, res, next) => {
    const authHeader = req.headers.authorization || req.headers.Authorization;
    if (typeof authHeader === "string") {
        const token = authHeader.split(" ")[1];
        jsonwebtoken_1.default.verify(token, process.env.JWT_SECRET, (err, user) => {
            if (err) {
                return res.status(401).json({ error: err.message });
            }
            console.log(user);
            req.user = user;
            next();
        });
    }
    else {
        res.status(401).json({ error: "Not an authorized user" });
    }
};
exports.authenticateJWT = authenticateJWT;
const authenticateAdminJWT = (req, res, next) => {
    const authHeader = req.headers.authorization || req.headers.Authorization;
    if (typeof authHeader === "string") {
        const token = authHeader.split(" ")[1];
        jsonwebtoken_1.default.verify(token, process.env.JWT_SECRET_ADMIN, (err, user) => {
            if (err) {
                return res.status(401).json({ error: err.message });
            }
            console.log(user);
            req.user = user;
            next();
        });
    }
    else {
        res.status(401).json({ error: "Not an authorized user" });
    }
};
exports.authenticateAdminJWT = authenticateAdminJWT;
//# sourceMappingURL=authMiddleware.js.map