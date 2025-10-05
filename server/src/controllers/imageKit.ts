import ImageKit from "imagekit";

// Initialize ImageKit
// Ensure you have these variables in your .env file
const imagekit = new ImageKit({
    publicKey: process.env.IMAGEKIT_PUBLIC_KEY!,
    privateKey: process.env.IMAGEKIT_PRIVATE_KEY!,
    urlEndpoint: process.env.IMAGEKIT_URL_ENDPOINT!,
});

/**
 * Uploads a file to ImageKit.
 * @param file The file buffer.
 * @param fileName The name for the uploaded file.
 * @param folder The folder in ImageKit to upload to.
 * @returns The URL of the uploaded file.
 */
export const uploadToImageKit = async (
    file: Buffer,
    fileName: string,
    folder: string
): Promise<string> => {
    try {
        const response = await imagekit.upload({
            file,
            fileName,
            folder,
            useUniqueFileName: true, // This is recommended to avoid name conflicts
        });
        return response.url;
    } catch (error) {
        console.error("Error uploading to ImageKit:", error);
        throw new Error("Failed to upload image.");
    }
};
