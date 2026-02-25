# Chateject for Swift

Swift library that recovers stream and chat data from Twitch.

Based on my TypeScript Chateject library, which is at the same time built with [TwitchDownloader](https://github.com/lay295/TwitchDownloader) as a reference.

It's called Chateject in reference to with my larger [Chatrewind](https://github.com/soywig/chatrewind) project.

Done in a few hours. Didn't clean the code. Probably didn't test enough. I'll update it as I see necessary.

## Reference

* `Chateject`: Everything hangs from here. You have to provide your own Twitch API key.
* `Chateject.downloadChatComments(streamId)`: Retrieves a full log of the stream chat.
* `Chateject.downloadStreamMetadata`: Retrieves basic metadata about the stream.
* `Chateject.downloadFullLog`: `Retrieves both.`
