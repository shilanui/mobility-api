import cloudinary from "../storage/cloudinary";

export const uploadImage = async (path: string) => {
  const result = await cloudinary.uploader.upload(path);
  return result.secure_url;
};
