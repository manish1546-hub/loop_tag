"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.addProduct = exports.getAllProducts = void 0;
const express_async_handler_1 = __importDefault(require("express-async-handler"));
const productModel_1 = __importDefault(require("../models/productModel"));
const imageKit_1 = require("./imageKit");
/**
 * @desc   Get all products
 * @route  GET /api/products
 * @access Public
 */
const getAllProducts = (0, express_async_handler_1.default)(async (req, res) => {
    const products = await productModel_1.default.find({}).sort({ createdAt: -1 });
    res.status(200).json(products);
});
exports.getAllProducts = getAllProducts;
/**
 * @desc   Add a new product
 * @route  POST /api/products
 * @access Public
 */
const addProduct = (0, express_async_handler_1.default)(async (req, res) => {
    const { productName, price, discountedPrice, description, category } = req.body;
    const files = req.files;
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
    const uploadPromises = files.map(file => (0, imageKit_1.uploadToImageKit)(file.buffer, file.originalname, "products"));
    const imageUrls = await Promise.all(uploadPromises);
    // --- Create and save the new product ---
    const newProduct = await productModel_1.default.insertOne({
        productName,
        price: Number(price),
        discountedPrice: discountedPrice ? Number(discountedPrice) : undefined,
        description,
        category,
        imageUrls,
    });
    if (newProduct) {
        res.status(201).json(newProduct);
    }
    else {
        res.status(500);
        throw new Error("Failed to create the product.");
    }
});
exports.addProduct = addProduct;
//# sourceMappingURL=productController.js.map