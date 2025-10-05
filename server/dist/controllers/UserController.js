"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.currentUser = exports.loginUser = exports.registerUser = void 0;
const express_async_handler_1 = __importDefault(require("express-async-handler"));
const bcryptjs_1 = __importDefault(require("bcryptjs"));
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const UserModel_1 = __importDefault(require("../models/UserModel"));
//@desc Register a user
//@route POST /users/register
//@access public
const registerUser = (0, express_async_handler_1.default)(async (req, res) => {
    const { email, password } = req.body;
    if (!email || !password) {
        res.status(401).json({ message: "All fields are mandatory!" });
        return;
    }
    const userExists = await UserModel_1.default.findOne({ email });
    if (userExists) {
        res.status(400).json({ message: "User already exists try logging in!" });
        return;
    }
    // Hash password
    const hashedPassword = await bcryptjs_1.default.hash(password, 10);
    const user = await UserModel_1.default.create({
        email: email,
        password: hashedPassword,
    });
    if (user) {
        const accessToken = jsonwebtoken_1.default.sign({ userId: user._id, email: user.email }, process.env.JWT_SECRET, { expiresIn: '1d' });
        const refreshToken = jsonwebtoken_1.default.sign({ userId: user._id, email: user.email }, process.env.JWT_SECRET, { expiresIn: '7d' });
        res.status(201).json({ accessToken, refreshToken });
    }
    else {
        res.status(501).json({ message: "Some error occurred while creating user, try again!" });
    }
});
exports.registerUser = registerUser;
//@desc Login user
//@route POST /users/login
//@access public
const loginUser = (0, express_async_handler_1.default)(async (req, res) => {
    const { email, password } = req.body;
    if (!email || !password) {
        res.status(401).json({ message: "All fields are mandatory!" });
        return;
    }
    const user = await UserModel_1.default.findOne({ email });
    if (!user) {
        res.status(404).json({ message: "No user found try creating one!" });
        return;
    }
    if (user && (email === process.env.ADMIN_EMAIL && password === process.env.ADMIN_PASSWORD)) {
        const accessToken = jsonwebtoken_1.default.sign({ userId: user._id, email: user.email }, process.env.JWT_SECRET_ADMIN, { expiresIn: '1d' });
        const refreshToken = jsonwebtoken_1.default.sign({ userId: user._id, email: user.email }, process.env.JWT_SECRET_ADMIN, { expiresIn: '7d' });
        res.status(200).json({ accessToken, refreshToken, isAdmin: true });
    }
    // Compare password with hashed password
    else if (user && (await bcryptjs_1.default.compare(password, user.password))) {
        const accessToken = jsonwebtoken_1.default.sign({ userId: user._id, email: user.email }, process.env.JWT_SECRET, { expiresIn: '1d' });
        const refreshToken = jsonwebtoken_1.default.sign({ userId: user._id, email: user.email }, process.env.JWT_SECRET, { expiresIn: '7d' });
        res.status(200).json({ accessToken, refreshToken });
    }
    else {
        res.status(401).json({ message: 'Incorrect credentials' });
    }
});
exports.loginUser = loginUser;
//@desc Current user info
//@route POST /users/current
//@access private
const currentUser = (0, express_async_handler_1.default)(async (req, res) => {
    if (!req.user) {
        res.status(401).json({ message: "Unauthorized" });
        return;
    }
    const user = await UserModel_1.default.findById(req.user.userId);
    if (!user) {
        res.status(404).json({ message: "User not found" });
        return;
    }
    res.status(200).json({ message: 'User success', user });
});
exports.currentUser = currentUser;
//# sourceMappingURL=UserController.js.map