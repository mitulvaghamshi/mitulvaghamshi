package me.mitul.portfolio

import app.cash.sqldelight.db.SqlDriver

interface Platform {
    val year: String
}

expect fun getPlatform(): Platform

interface DriverFactory {
    val driver: SqlDriver
}
