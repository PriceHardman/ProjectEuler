async function sleep(ms: number): Promise<number> {
    return new Promise((resolve) => {
        setTimeout(() => {
            resolve(ms);
        }, ms);
    });
}

async function run() {
    console.log("Starting")
    const jobs = [sleep(1000), sleep(2000), sleep(3000)]
    const results = await Promise.all(jobs)
    console.log("Finished: ", results)
    return results
}

console.log(run())




