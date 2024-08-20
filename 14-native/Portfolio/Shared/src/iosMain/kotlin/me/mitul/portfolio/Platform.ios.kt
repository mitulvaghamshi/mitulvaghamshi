package me.mitul.portfolio

import app.cash.sqldelight.driver.native.NativeSqliteDriver
import platform.Foundation.NSDate
import platform.Foundation.NSDateFormatter

class IOSPlatform : Platform {
    override val year: String
        get() {
            val formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy"
            return formatter.stringFromDate(NSDate())
        }
}

actual fun getPlatform(): Platform = IOSPlatform()

class IOSDriverFactory : DriverFactory {
    override val driver = NativeSqliteDriver(
        name = "RepoDatabase.db",
        schema = RepoDatabase.Schema,
    )
}
