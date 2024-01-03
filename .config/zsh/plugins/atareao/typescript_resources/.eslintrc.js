module.exports = {
  plugins: [
    "@stylistic/ts",
  ],
  parser: "@typescript-eslint/parser",
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:@typescript-eslint/stylistic',
    'plugin:@typescript-eslint/strict',
  ],
  rules: {
    '@stylistic/ts/indent': ["error", 4],
    '@stylistic/ts/semi': "error",
    '@stylistic/ts/key-spacing': ["error", {"beforeColon": false, "afterColon": true}],
    '@stylistic/ts/type-annotation-spacing': "error",
  }
};

