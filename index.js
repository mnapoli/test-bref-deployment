// AWS Lambda handler
exports.handler = async (event) => {
    const version = process.env.AWS_LAMBDA_FUNCTION_VERSION ?? 'unknown';

    console.log('Version: ' + version);

    return {
        statusCode: 200,
        body: JSON.stringify('Hello from version ' + version),
    };
}
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
// foo
