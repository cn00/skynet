#include <str2args/str2args.h>
#include "command.h"

#include <lua.hpp>
extern "C"
{
    int executeCommand(const char *cmd) {
        int argc = 0;
        char temp[ARGC_MAX][ARGV_LEN_MAX];
        char *argv[ARGC_MAX];
        if (!str2args(cmd, temp, &argc)) {
            return 7;
        }
        for (int i = 0; i < argc; i++) {
            argv[i] = temp[i];
                //        printf("arg[%d]:[%s]", i, argv[i]);
        }
        p7zip_main(argc, argv);
        return 0;//
    }


    int execute(lua_State *L) {
        const char *cmd = luaL_checkstring( L,1 );
        executeCommand(cmd);
        return 0;
    }

    extern int luaopen_p7zip(lua_State *L)
    {
        lua_settop(L, 0);
        lua_newtable(L);
        lua_pushcfunction(L, execute);
        lua_setfield(L, -2, "execute");

        return 1;
    }

} //extern "C"
