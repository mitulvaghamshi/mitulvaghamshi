const express = require("express");
const router = express.Router();
const recordController = require("../../controllers/record-controller");

/**
 * @openapi
 * /api/v1/workouts/{workoutId}/records:
 *   get:
 *     tags:
 *       - workouts
 *     parameters:
 *       - in: path
 *         name: workoutId
 *         schema:
 *           type: string
 *         required: true
 *         description: The id of the workout
 *     responses:
 *       200:
 *         description: OK
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: string
 *                   example: OK
 *                 data:
 *                   type: array
 *                   items:
 *                     $ref: "#/components/schemas/record"
 *       5XX:
 *         description: FAILED
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: string
 *                   example: FAILED
 *                 data:
 *                   type: object
 *                   properties:
 *                     error:
 *                       type: string
 *                       example: "Some error message"
 */
router.get("/:workoutId/records", recordController.getRecordForWorkout);

module.exports = router;
