import mongoose, { Schema, Document, Model } from "mongoose";

export interface ProductDocument extends Document {
  productName: string;
  price: number;
  tax?: number;
  description: string;
  category: string;
  imageUrls: string[];
}

const productSchema = new Schema(
  {
    productName: { type: String, required: true },
    price: { type: Number, required: true },
    tax: { type: Number },
    description: { type: String, required: true },
    category: { type: String, required: true },
    imageUrls: { type: [String], required: true },
  },
  { timestamps: true }
);

const Product: Model<ProductDocument> =
  mongoose.models.Product ||
  mongoose.model<ProductDocument>("Product", productSchema);

export default Product;
