exports.handler = async (event) => {
    const response = {
        statusCode: 200,
        headers: {
            'Content-Type': 'text/html',
        },
        body: '<html><body><h1>Greetings from Lambda!</h1></body></html>',
    };
    return response;
};
