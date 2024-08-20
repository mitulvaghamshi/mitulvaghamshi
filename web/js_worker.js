import { fileURLToPath } from "url";
import { Worker, isMainThread, threadId } from "worker_threads";

if (isMainThread) {
    console.log(`Running on main thread: id-${threadId}`);
    for (let index = 0; index < 5; index++) {
        console.log(`>> Spawn new thread...`);
        new Worker(fileURLToPath(import.meta.url));
    }
} else {
    console.log(`Running on worker thread: id-${threadId}`);
}
