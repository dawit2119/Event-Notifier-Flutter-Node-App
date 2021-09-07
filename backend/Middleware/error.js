
export const errorHandler = (err, req, res, next) => {
  console.log(err.stack.red);
  res
    .status(err.statusCode || 5000)
    .json({ success: false, error: err.message || "Server error" });
};
