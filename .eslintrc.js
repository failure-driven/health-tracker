module.exports = {
  env: {
    browser: true,
    es2021: true,
    jquery: true,
  },
  extends: ["plugin:react/recommended", "airbnb", "prettier", "plugin:prettier/recommended"],
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 12,
    sourceType: "module",
  },
  plugins: ["prettier", "react"],
  rules: {
    "prettier/prettier": "error",
    "react/jsx-filename-extension": [1, { extensions: [".js", ".jsx"] }],
  },
};
