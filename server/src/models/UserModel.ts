import mongoose, { Document, Schema } from 'mongoose';

// Define the User interface
interface IUser extends Document {
    email: string;
    password: string;
    createdAt?: Date;
    updatedAt?: Date;
}

// Define the user schema
const userSchema = new Schema<IUser>(
    {
        email: {
            type: String,
            required: [true, 'Email ID is missing'],
            unique: true, // Ensures uniqueness
        },
        password: {
            type: String,
            required: true, // Ensures password is mandatory
        },
    },
    {
        timestamps: true,
    }
);

// Check if the model already exists to prevent redefining
const User = mongoose.models.User || mongoose.model<IUser>('User', userSchema);

export default User;
