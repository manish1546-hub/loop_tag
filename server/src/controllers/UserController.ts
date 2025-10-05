import { Request, Response } from "express";
import asyncHandler from "express-async-handler";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import User from "../models/UserModel";

interface AuthRequest extends Request {
    user?: { userId: string; email: string };
}

//@desc Register a user
//@route POST /users/register
//@access public
const registerUser = asyncHandler(async (req: Request, res: Response) => {
    const { email, password } = req.body;

    if ( !email || !password) {
        res.status(401).json({ message: "All fields are mandatory!" });
        return;
    }

    const userExists = await User.findOne({ email });
    if (userExists) {
        res.status(400).json({ message: "User already exists try logging in!" });
        return;
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await User.create({
        email: email,
        password: hashedPassword,
    });

    if (user) {
        const accessToken = jwt.sign(
            { userId: user._id, email: user.email }, process.env.JWT_SECRET as string, { expiresIn: '1d' }
        );

        const refreshToken = jwt.sign(
            { userId: user._id, email: user.email }, process.env.JWT_SECRET as string, { expiresIn: '7d' }
        );

        res.status(201).json({ accessToken, refreshToken });
    } else {
        res.status(501).json({ message: "Some error occurred while creating user, try again!" });
    }
});

//@desc Login user
//@route POST /users/login
//@access public
const loginUser = asyncHandler(async (req: Request, res: Response) => {
    const { email, password } = req.body;

    if (!email || !password) {
        res.status(401).json({ message: "All fields are mandatory!" });
        return;
    }

    const user = await User.findOne({ email });

    if (!user) {
        res.status(404).json({ message: "No user found try creating one!" });
        return;
    }

    if (user && (email === process.env.ADMIN_EMAIL as string && password === process.env.ADMIN_PASSWORD as string)) {
        const accessToken = jwt.sign(
            { userId: user._id, email: user.email }, process.env.JWT_SECRET_ADMIN as string, { expiresIn: '1d' }
        );

        const refreshToken = jwt.sign(
            { userId: user._id, email: user.email }, process.env.JWT_SECRET_ADMIN as string, { expiresIn: '7d' }
        );

        res.status(200).json({ accessToken, refreshToken, isAdmin: true });
    }

    // Compare password with hashed password
    else if (user && (await bcrypt.compare(password, user.password))) {
        const accessToken = jwt.sign(
            { userId: user._id, email: user.email }, process.env.JWT_SECRET as string, { expiresIn: '1d' }
        );

        const refreshToken = jwt.sign(
            { userId: user._id, email: user.email }, process.env.JWT_SECRET as string, { expiresIn: '7d' }
        );

        res.status(200).json({ accessToken, refreshToken });
    } else {
        res.status(401).json({ message: 'Incorrect credentials' });
    }
});

//@desc Current user info
//@route POST /users/current
//@access private
const currentUser = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    if (!req.user) {
        res.status(401).json({ message: "Unauthorized" });
        return;
    }

    const user = await User.findById(req.user.userId);

    if (!user) {
        res.status(404).json({ message: "User not found" });
        return;
    }

    res.status(200).json({ message: 'User success', user });
});

export { registerUser, loginUser, currentUser };

