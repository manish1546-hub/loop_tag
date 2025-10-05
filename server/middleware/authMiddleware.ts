import jwt from "jsonwebtoken";
import { Request, Response, NextFunction } from "express";

const authenticateJWT = (req: Request, res: Response, next: NextFunction) => {
    const authHeader = req.headers.authorization || req.headers.Authorization;

    if (typeof authHeader === "string") {
        const token = authHeader.split(" ")[1];

        jwt.verify(token, process.env.JWT_SECRET as string, (err, user) => {
            if (err) {
                return res.status(401).json({ error: err.message });
            }

            console.log(user);
            req.user = user;
            next();
        });
    } else {
        res.status(401).json({ error: "Not an authorized user" });
    }
};

export default authenticateJWT;
