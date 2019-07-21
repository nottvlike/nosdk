#include <mxml.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

#ifndef luaL_register
#define luaL_register(L,n,f) \
    { if ((n) == NULL) luaL_setfuncs(L,f,0); else luaL_newlib(L,f); }
#endif

static int lelementFirstChild(lua_State *L)
{
	mxml_node_t* current = lua_touserdata(L, 1);
	if (current != NULL && current->child != NULL)
		lua_pushlightuserdata(L, (void*)current->child);
	else
		lua_pushnil(L);
	return 1;
}

static int lelementNextChild(lua_State *L)
{
	mxml_node_t* current = lua_touserdata(L, 1);
	if (current != NULL && current->next != NULL)
		lua_pushlightuserdata(L, (void*)current->next);
	else
		lua_pushnil(L);

	return 1;
}

static int lelementType(lua_State *L)
{
	mxml_node_t* current = lua_touserdata(L, 1);
	lua_pushinteger(L, current->type);
	return 1;
}

static int lelementName(lua_State *L)
{
	mxml_node_t* current = lua_touserdata(L, 1);
	lua_pushstring(L, current->value.element.name);
	return 1;
}

static int lelementAttrCount(lua_State *L)
{
	mxml_node_t* current = lua_touserdata(L, 1);
	lua_pushinteger(L, current->value.element.num_attrs);
	return 1;
}

static int lelementAttrName(lua_State *L)
{
	mxml_node_t* current = lua_touserdata(L, 1);
	int index = lua_tointeger(L, 2);
	mxml_element_t attrs = current->value.element;

	lua_pushstring(L, (attrs.attrs + index)->name);
	return 1;
}

static int lelementAttrValue(lua_State *L)
{
	mxml_node_t* current = lua_touserdata(L, 1);
	int index = lua_tointeger(L, 2);
	mxml_element_t attrs = current->value.element;

	lua_pushstring(L, (attrs.attrs + index)->value);
	return 1;
}

static int lloadFile(lua_State *L)
{
	const char* path = lua_tostring(L, 1);
	int index = lua_tointeger(L, 2);
	
	FILE *fp = fopen(path, "r");
	mxml_node_t* current = mxmlLoadFile(NULL, fp, MXML_NO_CALLBACK);
	fclose(fp);

	lua_pushlightuserdata(L, (void*)current);
	return 1;
}

int luaopen_mxml(lua_State *L) 
{
	luaL_Reg l[] = {
		{ "elementFirstChild" , lelementFirstChild },
		{ "elementNextChild", lelementNextChild },
		{ "elementType", lelementType },
		{ "elementName" , lelementName },
		{ "elementAttrCount", lelementAttrCount },
		{ "elementAttrName", lelementAttrName },
		{ "elementAttrValue", lelementAttrValue },
		{ "loadFile", lloadFile },
		{ NULL, NULL },
	};

	lua_newtable(L);
	luaL_register(L, NULL, l);

	lua_setglobal(L, "mxml");

	return 1;
}