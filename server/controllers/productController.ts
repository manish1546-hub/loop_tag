import asyncHandler from "express-async-handler";
import { Request, Response } from "express";

const productOrigin = asyncHandler(async (req: Request, res: Response) => {
    console.log("created product successfully");
    res.status(200).json({ route: "product" });
});

export { productOrigin };
