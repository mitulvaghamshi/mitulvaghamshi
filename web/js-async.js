// Promise
// -----------------------------------------------------------------
const myPromise = new Promise((resolve, reject) => {
  setTimeout(() => {
    if (isCat()) {
      resolve("Operation completed successfully!");
    } else {
      reject("Operation failed!");
    }
  }, 2000);
});

myPromise.then((result) => {
  console.log(result);
}).catch((error) => {
  console.log(error);
});

function fetchUserData(userId) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve({ id: userId, name: "John Doe" });
    }, 1000);
  });
}

function fetchUserPosts(user) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve([
        { title: "Post 1", author: user.name },
        { title: "Post 2", author: user.name },
      ]);
    }, 1000);
  });
}

fetchUserData(123).then((user) => {
  console.log("User:", user);
  return fetchUserPosts(user);
}).then((posts) => {
  console.log("Posts:", posts);
}).catch((error) => {
  console.log("Error:", error);
});
// -----------------------------------------------------------------

// Async/Await
// -----------------------------------------------------------------
async function performOperation() {
  try {
    const result = await myPromise;
    console.log(result);
  } catch (error) {
    console.log(error);
  }
}

performOperation();

async function getUserDataAndPosts(userId) {
  try {
    const user = await fetchUserData(userId);
    const posts = await fetchUserPosts(user);
    return posts;
  } catch (error) {
    console.log("Error:", error);
    throw error; // Re-throw the error if needed
  }
}

getUserDataAndPosts(123);
// -----------------------------------------------------------------

// Example: Making API Calls
// -----------------------------------------------------------------
function fetchDataWithPromises() {
  fetch("https://jsonplaceholder.typicode.com/users/1").then((response) => {
    if (!response.ok) throw new Error("Network response was not ok");
    return response.json();
  }).then((user) => {
    console.log("User data:", user);
    return fetch(`https://jsonplaceholder.typicode.com/users/${user.id}/posts`);
  }).then((response) => {
    response.json();
  }).then((posts) => {
    console.log("User posts:", posts);
  }).catch((error) => {
    console.error("Error:", error);
  });
}

async function fetchDataWithAsyncAwait() {
  try {
    const userResponse = await fetch("https://jsonplaceholder.typicode.com/users/1");
    if (!userResponse.ok) throw new Error("Network response was not ok");
    const user = await userResponse.json();
    const postsResponse = await fetch(`https://jsonplaceholder.typicode.com/users/${user.id}/posts`);
    const posts = await postsResponse.json();
    console.log("User posts:", posts);
  } catch (error) {
    console.error("Error:", error);
  }
}
// -----------------------------------------------------------------

// Example: Handling Multiple Async Operations
// -----------------------------------------------------------------
function processMultipleOperations() {
  const promise1 = fetch("https://jsonplaceholder.typicode.com/users/1");
  const promise2 = fetch("https://jsonplaceholder.typicode.com/users/2");
  const promise3 = fetch("https://jsonplaceholder.typicode.com/users/3");

  Promise.all([promise1, promise2, promise3]).then((responses) => {
    return Promise.all(responses.map((response) => response.json()));
  }).then((users) => {
    console.log("All users:", users);
  }).catch((error) => {
    console.error("Error:", error);
  });
}

async function processMultipleOperationsAsync() {
  try {
    const promise1 = fetch("https://jsonplaceholder.typicode.com/users/1");
    const promise2 = fetch("https://jsonplaceholder.typicode.com/users/2");
    const promise3 = fetch("https://jsonplaceholder.typicode.com/users/3");

    const responses = await Promise.all([promise1, promise2, promise3]);
    const users = await Promise.all(responses.map((response) => response.json()));

    console.log("All users:", users);
  } catch (error) {
    console.error("Error:", error);
  }
}

axios.get("/api/users") // Axios library returns Promises
  .then((response) => response.data)
  .then((users) => console.log(users))
  .catch((error) => console.error(error));

fetch("/api/data") // fetch() API returns Promises
  .then((response) => response.json())
  .then((data) => console.log(data));

import { readFile } from "fs/promises";
readFile("./config.json", "utf8") // Node.js fs.promises returns Promises
  .then((data) => JSON.parse(data))
  .then((config) => console.log(config));

const processUsers = (userIds) => { // Functional composition with Promises
  return Promise.all(userIds.map((id) => fetchUser(id))) // Transform each ID to a Promise
    .then((users) => users.filter((user) => user.active)) // Filter active users
    .then((activeUsers) => activeUsers.map((user) => user.email)); // Extract emails
};

// Pipeline approach
const createUserPipeline = (userId) => {
  return fetchUser(userId)
    .then(validateUser)
    .then(enrichUserData)
    .then(formatUserResponse)
    .then(logUserActivity);
};

// Composing multiple Promise-returning functions
const compose = (...fns) => (value) => {
  fns.reduce((promise, fn) => promise.then(fn), Promise.resolve(value));
};

const userProcessor = compose(fetchUser, validateUser, enrichUserData, saveUser);

// Timeout utility
function timeout(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

// Retry utility with exponential backoff
function retry(fn, retries = 3, delay = 1000) {
  return fn().catch((error) => {
    if (retries > 0) {
      console.log(`Retrying... ${retries} attempts left`);
      return timeout(delay).then(() => retry(fn, retries - 1, delay * 2));
    }
    throw error;
  });
}

// Rate limiting utility
function rateLimit(fn, maxCalls, timeWindow) {
  let calls = [];

  return function (...args) {
    const now = Date.now();
    calls = calls.filter((time) => now - time < timeWindow);

    if (calls.length >= maxCalls) {
      const waitTime = timeWindow - (now - calls[0]);
      return timeout(waitTime).then(() => fn.apply(this, args));
    }

    calls.push(now);
    return fn.apply(this, args);
  };
}

// Usage
const apiCall = () => fetch("/api/data").then((r) => r.json());
const resilientApiCall = retry(apiCall, 3);
const rateLimitedApiCall = rateLimit(apiCall, 5, 60000); // 5 calls per minute

async function processUserData(userId) {
  try {
    const user = await fetchUser(userId);
    const preferences = await fetchUserPreferences(user.id);
    const recommendations = await generateRecommendations(user, preferences);

    return { user, preferences, recommendations };
  } catch (error) {
    console.error("Failed to process user data:", error);
    throw error;
  }
}

async function complexOperation(data) {
  try {
    // First level: preprocessing errors
    const processedData = await preprocessData(data);

    try {
      // Second level: critical operation errors
      const result = await performCriticalOperation(processedData);
      return result;
    } catch (criticalError) {
      // Handle critical operation errors specifically
      console.error("Critical operation failed:", criticalError);

      // We can make decisions based on the error type
      if (criticalError.code === "TEMPORARY_FAILURE") {
        console.log("Attempting fallback operation...");
        const fallbackResult = await performFallbackOperation(processedData);
        return fallbackResult;
      } else {
        // Re-throw if it's not recoverable
        throw new Error(`Critical failure: ${criticalError.message}`);
      }
    }
  } catch (preprocessError) {
    // Handle preprocessing errors differently
    console.error("Preprocessing failed:", preprocessError);

    // We can inspect the error and decide how to handle it
    if (preprocessError.code === "INVALID_DATA") {
      throw new Error("Invalid input data provided");
    } else {
      throw new Error("Unable to process data");
    }
  }
}

async function smartUserProcess(userId) {
  try {
    // First, get the user data
    const user = await fetchUser(userId);
    console.log(`Processing user: ${user.name} (Premium: ${user.isPremium})`);

    // Make decisions based on the async result
    if (user.isPremium) {
      console.log("User is premium - fetching premium features");

      // Premium users get additional data
      const premiumData = await fetchPremiumFeatures(user.id);

      // We can make further decisions based on premium data
      if (premiumData.analyticsEnabled) {
        console.log("Analytics enabled - generating premium analytics");
        const analytics = await generatePremiumAnalytics(user, premiumData);
        return { user, premiumData, analytics };
      } else {
        return { user, premiumData };
      }
    } else {
      console.log("User is basic - fetching basic features");

      // Basic users get different treatment
      const basicData = await fetchBasicFeatures(user.id);

      // Check if user qualifies for upgrade prompts
      if (basicData.usageLevel > 0.8) {
        console.log("User has high usage - checking upgrade eligibility");
        const upgradeOffer = await checkUpgradeEligibility(user);
        return { user, basicData, upgradeOffer };
      } else {
        return { user, basicData };
      }
    }
  } catch (error) {
    console.error("User processing failed:", error);

    // Even error handling can be conditional
    if (error.code === "USER_NOT_FOUND") {
      throw new Error("User does not exist");
    } else if (error.code === "NETWORK_ERROR") {
      throw new Error("Network connectivity issue");
    } else {
      throw error;
    }
  }
}
// -----------------------------------------------------------------

// Sequential vs Parallel
// -----------------------------------------------------------------
// This takes ~3 seconds total (1 + 1 + 1)
async function sequentialOperations() {
  console.time("Sequential Operations");

  const result1 = await operation1(); // 1 second - must complete first
  console.log("Operation 1 completed:", result1);

  const result2 = await operation2(); // 1 second - starts after operation1
  console.log("Operation 2 completed:", result2);

  const result3 = await operation3(); // 1 second - starts after operation2
  console.log("Operation 3 completed:", result3);

  console.timeEnd("Sequential Operations");
  return [result1, result2, result3];
}

// This takes ~1 second total (all operations run simultaneously)
async function parallelOperations() {
  console.time("Parallel Operations");

  // Start all operations immediately - they run concurrently
  const promise1 = operation1(); // starts immediately
  const promise2 = operation2(); // starts immediately
  const promise3 = operation3(); // starts immediately

  console.log("All operations started, waiting for completion...");

  // Wait for all operations to complete
  const [result1, result2, result3] = await Promise.all([promise1, promise2, promise3]);

  console.log("All operations completed");
  console.timeEnd("Parallel Operations");
  return [result1, result2, result3];
}

async function mixedApproach(userIds) {
  console.time("Mixed Approach");

  // Step 1: Fetch all users in parallel (they're independent)
  console.log("Fetching users in parallel...");
  const users = await Promise.all(userIds.map((id) => fetchUser(id)));

  // Step 2: Process each user sequentially (to avoid overwhelming the recommendation service)
  console.log("Processing users sequentially...");
  const results = [];
  for (const user of users) {
    const preferences = await fetchUserPreferences(user.id);
    const recommendations = await generateRecommendations(user, preferences);
    results.push({ user, preferences, recommendations });

    // Small delay to be respectful to the API
    await new Promise((resolve) => setTimeout(resolve, 100));
  }

  console.timeEnd("Mixed Approach");
  return results;
}
// -----------------------------------------------------------------

// Error handling
// -----------------------------------------------------------------
function promiseErrorHandling() {
  return fetchData().then((data) => {
    console.log("Data fetched successfully");
    return processData(data);
  }).then((result) => {
    console.log("Data processed successfully");
    return saveResult(result);
  }).then((savedResult) => {
    console.log("Result saved successfully");
    return savedResult;
  }).catch((error) => {
    console.error("Error occurred in the chain:", error);
    // Handle different types of errors
    if (error.name === "NetworkError") {
      console.log("Network issue detected, attempting retry...");
      return retryOperation();
    } else if (error.name === "ValidationError") {
      console.log("Data validation failed:", error.message);
      return handleValidationError(error);
    } else if (error.name === "StorageError") {
      console.log("Storage operation failed, using fallback");
      return saveToFallbackStorage(error.data);
    } else {
      console.log("Unknown error type:", error);
      throw error; // Re-throw if we can't handle it
    }
  });
}

async function asyncAwaitErrorHandling() {
  try {
    console.log("Starting data processing...");

    const data = await fetchData();
    console.log("Data fetched successfully");

    const result = await processData(data);
    console.log("Data processed successfully");

    const savedResult = await saveResult(result);
    console.log("Result saved successfully");

    return savedResult;
  } catch (error) {
    console.error("Error occurred during processing:", error);

    // Handle different types of errors with more complex logic
    if (error.name === "NetworkError") {
      console.log("Network issue detected");

      // We can use async operations in error handling
      const retryCount = await getRetryCount();
      if (retryCount < 3) {
        console.log(`Retrying... (attempt ${retryCount + 1})`);
        await incrementRetryCount();
        return await retryOperation();
      } else {
        console.log("Max retries reached, switching to offline mode");
        return await switchToOfflineMode();
      }
    } else if (error.name === "ValidationError") {
      console.log("Data validation failed:", error.message);

      // Handle validation errors with user feedback
      await logValidationError(error);
      return handleValidationError(error);
    } else if (error.name === "StorageError") {
      console.log("Storage operation failed");

      // Try multiple fallback options
      try {
        return await saveToFallbackStorage(error.data);
      } catch (fallbackError) {
        console.log("Fallback storage also failed, using cache");
        return await saveToCache(error.data);
      }
    } else {
      console.log("Unknown error type, logging for analysis");
      await logErrorForAnalysis(error);
      throw error; // Re-throw unknown errors
    }
  }
}

async function advancedErrorHandling(userId) {
  try {
    const user = await fetchUser(userId);
    try {
      const sensitiveData = await fetchSensitiveData(user.id);
      return { user, sensitiveData };
    } catch (sensitiveError) {
      // Handle sensitive data errors specifically
      if (sensitiveError.code === "PERMISSION_DENIED") {
        console.log("User lacks permission for sensitive data");
        return { user, sensitiveData: null, reason: "permission_denied" };
      } else {
        // For other sensitive data errors, we still want to return the user
        console.warn("Sensitive data unavailable:", sensitiveError.message);
        return { user, sensitiveData: null, reason: "data_unavailable" };
      }
    }
  } catch (userError) {
    // Handle user fetching errors
    if (userError.code === "USER_NOT_FOUND") {
      throw new Error(`User ${userId} does not exist`);
    } else if (userError.code === "NETWORK_ERROR") {
      throw new Error("Unable to connect to user service");
    } else {
      throw new Error(`Failed to fetch user: ${userError.message}`);
    }
  }
}
// -----------------------------------------------------------------

// Best Practices
// -----------------------------------------------------------------
// Do this instead:
// Proper error handling with context and recovery
async function goodExample() {
  try {
    console.log("Starting data processing...");

    const data = await fetchData();
    console.log("Data fetched successfully");

    const processed = await processData(data);
    console.log("Data processed successfully");

    const result = await saveData(processed);
    console.log("Data saved successfully");

    return result;
  } catch (error) {
    // Log the error with context
    console.error("Data processing failed:", {
      error: error.message,
      step: error.step || "unknown",
      timestamp: new Date().toISOString(),
    });

    // Re-throw with more context or handle appropriately
    throw new Error(`Data processing failed: ${error.message}`);
  }
}

// Usage - caller knows how to handle failures
try {
  const result = await goodExample();
  console.log("Success:", result);
} catch (error) {
  console.error("Failed to process data:", error.message);
  // Handle the error appropriately for your application
  showErrorToUser("Data processing failed. Please try again.");
}

// Don't do this:
// Sequential when it could be parallel - this is inefficient!
async function inefficient() {
  console.time("Inefficient Approach");

  // These operations are independent but run one after another
  const user = await fetchUser(); // 500ms
  const posts = await fetchPosts(); // 300ms
  const comments = await fetchComments(); // 400ms
  // Total time: ~1200ms

  console.timeEnd("Inefficient Approach");
  return { user, posts, comments };
}

// Do this instead:
// Parallel execution - much more efficient!
async function efficient() {
  console.time("Efficient Approach");

  // Start all operations simultaneously
  const user_1 = fetchUser();
  const posts_1 = fetchPosts();
  const comments_1 = fetchComments();

  // Wait for all to complete
  const [user, posts, comments] = await Promise.all([user_1, posts_1, comments_1]);
  // Total time: ~500ms (longest individual operation)

  console.timeEnd("Efficient Approach");
  return { user, posts, comments };
}

async function efficientWithErrorHandling() {
  try {
    console.log("Starting parallel data fetch...");

    // Start all operations and handle individual failures
    const results = await Promise.allSettled([
      fetchUser().catch((error) => ({ error: error.message, type: "user" })),
      fetchPosts().catch((error) => ({ error: error.message, type: "posts" })),
      fetchComments().catch((error) => ({
        error: error.message,
        type: "comments",
      })),
    ]);

    // Process results and handle partial failures
    const [userResult, postsResult, commentsResult] = results;

    return {
      user: userResult.status === "fulfilled" ? userResult.value : null,
      posts: postsResult.status === "fulfilled" ? postsResult.value : [],
      comments: commentsResult.status === "fulfilled" ? commentsResult.value : [],
      errors: results
        .filter((result) => result.status === "rejected" || result.value?.error)
        .map((result) => result.reason || result.value?.error),
    };
  } catch (error) {
    console.error("Failed to fetch data:", error);
    throw error;
  }
}

// Avoid this:
// Mixing async/await with .then()
async function mixedPattern() {
  const data = await fetchData();
  // Suddenly switching to Promise chain style
  return processData(data).then((result) => {
    console.log("Processing complete");
    return saveResult(result);
  }).then((savedResult) => {
    return savedResult.id;
  }).catch((error) => {
    console.error("Error in promise chain:", error);
    throw error;
  });
}

// Do this instead:
// Consistent async/await
async function consistentPattern() {
  try {
    const data = await fetchData();
    console.log("Data fetched");

    const result = await processData(data);
    console.log("Processing complete");

    const savedResult = await saveResult(result);
    console.log("Result saved");

    return savedResult.id;
  } catch (error) {
    console.error("Error in async function:", error);
    throw error;
  }
}

// If you prefer Promises, be consistent with that too
function consistentPromisePattern() {
  return fetchData().then((data) => {
    console.log("Data fetched");
    return processData(data);
  }).then((result) => {
    console.log("Processing complete");
    return saveResult(result);
  }).then((savedResult) => {
    console.log("Result saved");
    return savedResult.id;
  }).catch((error) => {
    console.error("Error in promise chain:", error);
    throw error;
  });
}

// Add timeout wrapper for reliability
function withTimeout(promise, time) {
  const timeout = new Promise((_, reject) => {
    setTimeout(() => reject(new Error("Operation timed out")), time);
  });
  return Promise.race([promise, timeout]);
}

// Usage
async function reliableDataFetch(userId) {
  try {
    // Timeout after 5 seconds
    const userData = await withTimeout(fetchUserData(userId), 5000);
    return userData;
  } catch (error) {
    if (error.message === "Operation timed out") {
      console.log("Request timed out, using cached data");
      return getCachedUserData(userId);
    }
    throw error;
  }
}
// -----------------------------------------------------------------
