# Test task

This code changes the phone call date that is displayed on the account info page. Now the call date is taken from the [**server**](http://worldtimeapi.org/api/timezone/Europe/Moscow) - it displays current date and time in Moscow instead of the actual date and time the call was made at. 
Data is taken from the `unixtime` field because I decided to use `withUpdatedTimestamp` Telegram function in `CallListController` to pass the parsed server response to UI components the same way it is done in `ChatConroller`. And the aforenamed function expects Int32 parameter in unix time format, so we don't need `datetime`or `utc_datetime` fields for this task. `CallListAPIFetcher` is located in `submodules/CallListUI/Sources` so both files have the same target membership.
