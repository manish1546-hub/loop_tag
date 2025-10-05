/**
 * Uploads a file to ImageKit.
 * @param file The file buffer.
 * @param fileName The name for the uploaded file.
 * @param folder The folder in ImageKit to upload to.
 * @returns The URL of the uploaded file.
 */
export declare const uploadToImageKit: (file: Buffer, fileName: string, folder: string) => Promise<string>;
