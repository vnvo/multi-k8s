const keys = require("./keys");
const redis = require("redis");

const redisClient = redis.createClient({
    host: keys.redisHost,
    port: keys.redisPort,
    retry_strategy: () => 1000
});

const subsc = redisClient.duplicate();

function fib(index) {
    console.log('calc fib for:', index);
    if (index < 2) return 1;
    return fib(index - 1) + fib(index - 2);
}

subsc.on("message", (channel, message) => {
    console.log('received message:', message);
    redisClient.hset('values', message, fib(parseInt(message)));
});

subsc.subscribe('insert');
