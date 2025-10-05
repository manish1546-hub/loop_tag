import jwt from "jsonwebtoken";
import { Request, Response, NextFunction } from "express";
interface AuthRequest extends Request {
    user?: string | jwt.JwtPayload;
}
declare const authenticateJWT: (req: AuthRequest, res: Response, next: NextFunction) => void;
declare const authenticateAdminJWT: (req: AuthRequest, res: Response, next: NextFunction) => void;
export { authenticateJWT, authenticateAdminJWT };
