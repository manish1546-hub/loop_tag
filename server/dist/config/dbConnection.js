"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const mongoose_1 = __importDefault(require("mongoose"));
const connectDb = async () => {
    try {
        const connection = await mongoose_1.default.connect(process.env.MONGO_URI);
        console.log("Database connected: ", connection.connection.host, connection.connection.name);
    }
    catch (err) {
        console.error(err);
    }
};
exports.default = connectDb;
//# sourceMappingURL=dbConnection.js.map