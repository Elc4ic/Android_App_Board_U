package com.example.boardserver

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.boot.test.context.SpringBootTest


@SpringBootApplication
class ServerApplication

fun main(args: Array<String>) {
    runApplication<ServerApplication>(*args)
}

@SpringBootTest
class ServerApplicationTests {

/*    @Test
    fun makeCall(){
        val response = verifyService.makeCall("+79833061072")
        println(Json.encodeToString(response))
        assert(response?.data?.pincode != null)
    }*/

    /*@Autowired
    lateinit var cacheService: CacheService

    @Test
    fun testCacheService() {
        val newUser = UserOuterClass.User.newBuilder()
            .setName("cdcdcdc")
            .setUsername("sxsxssxs")
            .setPassword("qwertyyyy".hashPassword())
            .setPhone("79833061072").build()
        val user = newUser.fromUserGrpc(true)
        println(user.id)
        user.id?.let { cacheService.saveUser(it,user) }
        val codeString = user.id.toString()
        val code = cacheService.getUser(UUID.fromString(codeString))
        println(code.name)

        assert(true)
    }

    @Autowired
    lateinit var userService: UserService

    @Test
    fun testUserService() {
        val user = User(username = "eee")
        userRepository.save(user)
        val savedUser = userRepository.findByUsernameWithComments("eee").orElseThrow()
        val context = Context.current().withValue(ContextKeys.USER_ID_KEY, savedUser.id.toString())
        context.wrap {
            runBlocking {
                userService.deleteUser(Empty.getDefaultInstance())
            }
        }

        assert(true)
    }


    @Autowired
    lateinit var userRepository: UserRepository

    @Autowired
    lateinit var adRepository: AdRepository

    @Autowired
    lateinit var chatRepository: ChatRepository

    @Test
    fun testNewUserFromGrpc() {
        val newUser = UserOuterClass.User.newBuilder()
            .setName("cdcdcdc")
            .setUsername("sxsxssxs")
            .setPassword("qwertyyyy".hashPassword())
            .setPhone("79833061072").build()
        val user = newUser.fromUserGrpc(true)
        userRepository.save(user)
        val savedUser = userRepository.findByUsernameWithComments(user.username).orElseThrow()
        userRepository.delete(savedUser)
        assert(savedUser.id != null)
    }


    @Test
    fun testAddAd() {
        val ad = Ad(title = "dddddd")
        adRepository.save(ad)

        val savedAd = adRepository.findByTitle(ad.title).orElseThrow()
        adRepository.delete(savedAd)
        assert(savedAd.id != null)
    }

    @Test
    fun testCreateChat() {
        val user01 = User(id = UUID.randomUUID())
        val user02 = User(id = UUID.randomUUID())
        val ad = Ad(id = UUID.randomUUID())
        adRepository.save(ad)
        userRepository.save(user01)
        userRepository.save(user02)

        val user1 = userRepository.findUserWithChats(user01.id).orElseThrow()
        val user2 = userRepository.findUserWithChats(user02.id).orElseThrow()

        val chat = ad.createChat(user1, user2)

        user1.addChat(chat)
        user2.addChat(chat)

        userRepository.save(user1)
        userRepository.save(user2)

        chatRepository.save(chat)

        val savedChat = chatRepository.findChatBetweenUsersByIds(user1.id, user2.id, ad.id).orElseThrow()
        assert(chat.id == savedChat.id)
    }*/


}