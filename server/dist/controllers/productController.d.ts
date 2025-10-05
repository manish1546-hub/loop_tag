/**
 * @desc   Get all products
 * @route  GET /api/products
 * @access Public
 */
declare const getAllProducts: import("express").RequestHandler<import("express-serve-static-core").ParamsDictionary, any, any, import("qs").ParsedQs, Record<string, any>>;
/**
 * @desc   Add a new product
 * @route  POST /api/products
 * @access Public
 */
declare const addProduct: import("express").RequestHandler<import("express-serve-static-core").ParamsDictionary, any, any, import("qs").ParsedQs, Record<string, any>>;
export { getAllProducts, addProduct };
