package me.mitul.portfolio

import android.content.Context
import app.cash.sqldelight.driver.android.AndroidSqliteDriver
import java.text.DateFormat
import java.util.Date

class AndroidPlatform : Platform {
    override val year: String
        get() = DateFormat
            .getDateInstance(DateFormat.YEAR_FIELD)
            .format(Date())
            .takeLast(n = 4)
}

actual fun getPlatform(): Platform = AndroidPlatform()

class AndroidDriverFactory(context: Context) : DriverFactory {
    override val driver = AndroidSqliteDriver(
        context = context,
        name = "RepoDatabase.db",
        schema = RepoDatabase.Schema,
    )
}
