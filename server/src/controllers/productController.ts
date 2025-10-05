import asyncHandler from "express-async-handler";
import { Request, Response } from "express";
import Product from "../models/productModel";
import { uploadToImageKit } from "./imageKit";
import mongoose from "mongoose";

/**
 * @desc   Get all products
 * @route  GET /api/products
 * @access Public
 */
const getAllProducts = asyncHandler(async (req: Request, res: Response) => {
    const products = await Product.find({}).sort({ createdAt: -1 });
    res.status(200).json(products);
});

/**
 * @desc   Add a new product
 * @route  POST /api/products
 * @access Public
 */
const addProduct = asyncHandler(async (req: Request, res: Response) => {
    const { productName, price, tax, description, category } = req.body;
    const files = req.files as Express.Multer.File[];

    // --- Validation ---
    if (!productName || !price || !description || !category) {
        res.status(400);
        throw new Error("Please provide all required product fields.");
    }

    if (!files || files.length === 0) {
        res.status(400);
        throw new Error("Please upload at least one product image.");
    }

    // --- Upload images to ImageKit in parallel ---
    const uploadPromises = files.map(file => 
        uploadToImageKit(file.buffer, file.originalname, "products")
    );
    const imageUrls = await Promise.all(uploadPromises);

    // --- Create and save the new product ---
    const newProduct = await Product.insertOne({
        productName,
        price: Number(price),
        tax: tax ? Number(tax) : undefined,
        description,
        category,
        imageUrls,
    });

    if (newProduct) {
        res.status(201).json(newProduct);
    } else {
        res.status(500);
        throw new Error("Failed to create the product.");
    }
});

/**
 * @desc   Get a single product by ID
 * @route  GET /api/products/:id
 * @access Public
 */
const getProductById = asyncHandler(async (req: Request, res: Response) => {
    const { id } = req.params;

    // Check for a valid MongoDB ObjectId
    if (!mongoose.Types.ObjectId.isValid(id)) {
        res.status(404);
        throw new Error("Product not found, invalid ID format.");
    }

    const product = await Product.findById(id);

    if (product) {
        res.status(200).json(product);
    } else {
        res.status(404);
        throw new Error("Product not found.");
    }
});

export { getAllProducts, addProduct, getProductById };
