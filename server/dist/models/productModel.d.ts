import { Document, Model } from "mongoose";
export interface ProductDocument extends Document {
    productName: string;
    price: number;
    discountedPrice?: number;
    description: string;
    category: string;
    imageUrls: string[];
}
declare const Product: Model<ProductDocument>;
export default Product;
