import express from "express"
import {
    productOrigin
} from "../controllers/productController"

const router = express.Router()

router.get('/', productOrigin)

export default router;
    