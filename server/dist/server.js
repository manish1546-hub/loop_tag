"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// Basic Express.js server
const express_1 = __importDefault(require("express"));
const path_1 = __importDefault(require("path"));
// import connectDb from './config/dbConnection';
const app = (0, express_1.default)();
// DB config
// connectDb(); // Uncomment this after adding connection to DB
// Middleware
app.use(express_1.default.json());
const UserRoutes_1 = __importDefault(require("./routes/UserRoutes"));
app.use('/User', UserRoutes_1.default);
const productRoutes_1 = __importDefault(require("./routes/productRoutes"));
app.use('/product', productRoutes_1.default);
// Routes (Add your routes here)
// Example: app.use('/api', require('./routes/apiRoutes'));
// Server starting
app.get('/', (req, res) => {
    res.sendFile(path_1.default.join(process.cwd(), 'index.html')); // Adjust the path to match your file's location
});
// Start the server
const PORT = 8055;
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
//# sourceMappingURL=server.js.map