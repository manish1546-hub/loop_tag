import express from "express";
import multer from "multer";
import {
    getAllProducts,
    addProduct,
    getProductById
} from "../controllers/productController";
import { authenticateAdminJWT } from "src/middleware/authMiddleware";

const router = express.Router();

const storage = multer.memoryStorage();
const upload = multer({ storage });

router.get('/', authenticateAdminJWT, getAllProducts);
router.get('/:id', authenticateAdminJWT, getProductById);
router.post('/', authenticateAdminJWT, upload.array('photos', 5), addProduct);

export default router;
