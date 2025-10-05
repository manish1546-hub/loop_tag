import mongoose, { Schema, Document } from "mongoose";

    // Define the schema interface
    interface Iproduct extends Document {
        product: string;
    }
    
    // Define the schema
    const productSchema = new Schema<Iproduct>(
        {
            product: { type: String, required: true },
        },
        {
            timestamps: true,
        }
    );
    
    // Check if the model already exists to prevent redefining
    const product = mongoose.models.product || mongoose.model<Iproduct>("product", productSchema);
    
    export default product;
        