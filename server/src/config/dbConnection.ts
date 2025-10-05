import mongoose from 'mongoose'

const connectDb = async () => {
    try {
    const connection = await mongoose.connect(process.env.MONGO_URI!);
    console.log(
        "Database connected: ",
        connection.connection.host,
        connection.connection.name
    );
    } catch (err) {
    console.error(err);
    }
};

export default connectDb