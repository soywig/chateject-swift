import Testing
@testable import Chateject

// please set these before testing
fileprivate let clientId = ""
fileprivate let clientSecret = ""
fileprivate let streamId = "2703800897"

@Test func oAuth() async throws {
    _ = try await getOAuthToken(auth: TwitchAuth(
        clientId: clientId,
        clientSecret: clientSecret
    ))
}

@Test func meta() async throws {
    let chateject = Chateject(
        clientId: clientId,
        clientSecret: clientSecret
    )
    let result = try await chateject.downloadStreamMetadata(streamId: streamId)
    print(result!)
}

@Test func comments() async throws {
    let chateject = Chateject(
        clientId: clientId,
        clientSecret: clientSecret
    )
    let result = try await chateject.downloadChatComments(streamId: streamId)
    print(result.count, result.first ?? String(), result.last ?? String())
    #expect(result.count > 0)
}
