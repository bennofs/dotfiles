----------------------------------------
-- do not modify this table
local debug_level = {
    DISABLED = 0,
    LEVEL_1  = 1,
    LEVEL_2  = 2
}

----------------------------------------
-- set this DEBUG to debug_level.LEVEL_1 to enable printing debug_level info
-- set it to debug_level.LEVEL_2 to enable really verbose printing
-- set it to debug_level.DISABLED to disable debug printing
-- note: this will be overridden by user's preference settings
local DEBUG = debug_level.LEVEL_1

-- a table of our default settings - these can be changed by changing
-- the preferences through the GUI or command-line; the Lua-side of that
-- preference handling is at the end of this script file
local default_settings =
{
    debug_level  = DEBUG,
    enabled      = true, -- whether this dissector is enabled or not
    port         = 5115, -- default TCP port number for MAGIC-XPA
}


local dprint = function() end
local dprint2 = function() end
local function resetDebugLevel()
    if default_settings.debug_level > debug_level.DISABLED then
        dprint = function(...)
            info(table.concat({"Lua: ", ...}," "))
        end

        if default_settings.debug_level > debug_level.LEVEL_1 then
            dprint2 = dprint
        end
    else
        dprint = function() end
        dprint2 = dprint
    end
end
-- call it now
resetDebugLevel()

magicxpa_proto = Proto("magicxpa", "MAGIC-XPA Protocol")

local message_types = {
 [0] = "-",
 "ENGINE",
 "REQUEST SERVICE",
 "REQUEST QUERY",
 "REQUEST TERMINATION",
 "REQUEST PRIORITY",
 "REQUEST EXE",
 "RESULT",
 "ACKNOWLEDGE",
 "I_AM_ALIVE",
 "ERROR",
 "PING",
 "BUSY",
 "END CONNECTION",
 "CLOSE APPSERV",
 "RECONNECT",
 "QUE DEL",
 "REBUILD JRNL",
 "SYNC POOL",
 "GET QUE DATA",
 "END SYNC",
 "START SYNC",
 "GET ASYNC",
 "RETRY",
 "ENGINE PRIORITY",
 "ENGINE RESET COUNTER",
 "REQUEST ENGINE BLOCK",
 "REQUEST RESUME",
}

local main_fields = {
  { abbrev = "type", typ = ftypes.UINT8, name = "Message type", display = base.DEC, values = message_types },
  { abbrev = "item_count", typ = ftypes.UINT32, name = "Item count", display = base.DEC },
  { abbrev = "priority", typ = ftypes.UINT8, name = "Priority", display = base.DEC },
  { abbrev = "reqid", typ = ftypes.UINT32, name = "Request id", display = base.HEX },
  { abbrev = "a4", typ = ftypes.UINT32, name = "Unknown4", display = base.HEX },
  { abbrev = "a5", typ = ftypes.UINT32, name = "Unknown5", display = base.HEX },
  { abbrev = "host", typ = ftypes.STRINGZ, name = "Host" },
  { abbrev = "port", typ = ftypes.UINT16, name = "Port", display = base.DEC },
  { abbrev = "pid", typ = ftypes.UINT32, name = "Sender process id", display = base.DEC },
  { abbrev = "timestamp", typ = ftypes.UINT32, name = "Timestamp", display = base.DEC },
  { abbrev = "a12", typ = ftypes.UINT32, name = "Unknown12", display = base.HEX },
  { abbrev = "a10", typ = ftypes.UINT32, name = "Unknown10", display = base.HEX },
  { abbrev = "a11", typ = ftypes.UINT32, name = "Unknown11", display = base.HEX },
  { abbrev = "app_name", typ = ftypes.STRINGZ, name = "App name" },
  { abbrev = "prg_name", typ = ftypes.STRINGZ, name = "Program name" },
  { abbrev = "user_name", typ = ftypes.STRINGZ, name = "User name" },
  { abbrev = "password", typ = ftypes.STRINGZ, name = "Password" },
  { abbrev = "a17", typ = ftypes.STRINGZ, name = "Unknown17" },
  { abbrev = "flags", typ = ftypes.UINT32, name = "Flags", display = base.HEX },
  { abbrev = "rc", typ = ftypes.INT32, name = "Return code", display = base.DEC },
  { abbrev = "a20", typ = ftypes.UINT32, name = "Unknown20", display = base.HEX },
  { abbrev = "a21", typ = ftypes.UINT32, name = "Unknown21", display = base.HEX },
  { abbrev = "direct_target", typ = ftypes.STRINGZ, name = "Direct target" },
  { abbrev = "a24", typ = ftypes.UINT32, name = "Unknown24", display = base.HEX },
  { abbrev = "ctx", typ = ftypes.DOUBLE, name = "Context id" },
  { abbrev = "session", typ = ftypes.UINT32, name = "Session", display = base.DEC },
  { abbrev = "a28", typ = ftypes.UINT32, name = "Unknown28", display = base.HEX },
  { abbrev = "a29", typ = ftypes.UINT32, name = "Unknown29", display = base.HEX },
  { abbrev = "a30", typ = ftypes.UINT32, name = "Unknown30", display = base.HEX },
  { abbrev = "a31", typ = ftypes.UINT32, name = "Unknown31", display = base.HEX },
  { abbrev = "a32", typ = ftypes.UINT32, name = "Unknown32", display = base.HEX },
  { abbrev = "a33", typ = ftypes.UINT32, name = "Unknown33", display = base.HEX },
  { abbrev = "a34", typ = ftypes.UINT32, name = "Unknown34", display = base.HEX },
  { abbrev = "a35", typ = ftypes.UINT32, name = "Unknown35", display = base.HEX },
  { abbrev = "ctxgroup", typ = ftypes.STRINGZ, name = "Context group" },
  { abbrev = "session_id2", typ = ftypes.STRINGZ, name = "Session id 2" },
  { abbrev = "a23", typ = ftypes.UINT32, name = "Unknown23", display = base.HEX },
}

local proto_fields = {
  packet_size = ProtoField.uint32("magicxpa.packet_size", "Packet size", base.DEC, nil, 0x0FFFFFFF),
  mri_version = ProtoField.uint8("magicxpa.version", "MRI Protocol Version", base.HEX, nil, 0xF0),
  main_size = ProtoField.uint32("magicxpa.main_size", "Main size"),
  items_size = ProtoField.uint32("magicxpa.items_size", "Items size"),
  strings_size = ProtoField.uint32("magicxpa.strings_size", "Strings size"),
}

local proto_expert = {
  str_offset_mismatch = ProtoExpert.new(
    "magicxpa.str_offset_mismatch", "stored offset does not match calculated offset",
    expert.group.MALFORMED, expert.severity.WARN
  )
}

for _, field in ipairs(main_fields) do
  proto_fields[field.abbrev] = ProtoField.new(
    field.name,
    "magicxpa." .. field.abbrev,
    field.typ,
    field.values,
    field.display
  )
end

magicxpa_proto.fields = proto_fields
magicxpa_proto.experts = proto_expert

local main_size_field = Field.new("magicxpa.main_size")
local items_size_field = Field.new("magicxpa.items_size")
local strings_size_field = Field.new("magicxpa.strings_size")
local msgtype_field = Field.new("magicxpa.type")
local app_name_field = Field.new("magicxpa.app_name")
local prg_name_field = Field.new("magicxpa.prg_name")
local reqid_field = Field.new("magicxpa.reqid")
local item_count_field = Field.new("magicxpa.item_count")

function magicxpa_proto.dissector(tvbuf,pktinfo,root)
  pktinfo.cols.protocol:set("MAGIC-XPA")

  local packet_header_range = tvbuf:range(0, 4)
  local packet_size = packet_header_range:le_uint64():band(0x0FFFFFFF):tonumber()
  local mri_version = packet_header_range:le_uint64():band(0xF0000000):rshift(24):tonumber()
  local tree = root:add(magicxpa_proto, tvbuf:range(0, packet_size))

  -- dissect packet header
  tree:add_le(proto_fields.packet_size, packet_header_range)
  tree:add_le(proto_fields.mri_version, tvbuf:range(3, 1))

  -- find sizes
  tree:add_le(proto_fields.main_size, tvbuf:range(4, 4))
  tree:add_le(proto_fields.items_size, tvbuf:range(main_size_field()() + 4, 4))
  tree:add_le(proto_fields.strings_size, tvbuf:range(main_size_field()() + items_size_field()() + 4, 4))

  -- disect main area
  local str_base = main_size_field()() + items_size_field()() + 8 
  local str_offset = str_base
  function add_str_field(field, offset)
    local stored_offset = tvbuf(offset, 4):le_int()
    local str_size = tvbuf(offset + 4, 4):le_int()
    if str_size > 0 then
      local item = tree:add(field, tvbuf(str_offset, str_size))
      if not (str_offset - str_base == stored_offset) then
        local detail = "stored offset " .. stored_offset .. ", calculated offset " .. (str_offset - str_base)
        item:add_proto_expert_info(proto_expert.str_offset_mismatch, "offset mismatch: " .. detail)
      end
    end
    str_offset = str_offset + str_size
    return 8
  end

  function plain_field_adder(size)
      return function(field, offset)
        tree:add_le(field, tvbuf(offset, size))
        return size
      end
  end

  local add_struct_field = {
    [ftypes.UINT8] = plain_field_adder(1),
    [ftypes.UINT16] = plain_field_adder(2),
    [ftypes.UINT24] = plain_field_adder(3),
    [ftypes.UINT32] = plain_field_adder(4),
    [ftypes.UINT64] = plain_field_adder(8),
    [ftypes.INT8] = plain_field_adder(1),
    [ftypes.INT16] = plain_field_adder(2),
    [ftypes.INT24] = plain_field_adder(3),
    [ftypes.INT32] = plain_field_adder(4),
    [ftypes.INT64] = plain_field_adder(8),
    [ftypes.STRING] = add_str_field,
    [ftypes.STRINGZ] = add_str_field,
    [ftypes.DOUBLE] = plain_field_adder(8),
  }

  local main_offset = 8
  for _, field in pairs(main_fields) do
    local proto_field = proto_fields[field.abbrev]
    main_offset = main_offset + add_struct_field[field.typ](proto_field, main_offset)
  end

  -- set columns
  local info_msg = string.format(
    "%s (%s/%s) reqid %d item_count %d",
    message_types[msgtype_field()()],
    app_name_field() and app_name_field()() or "<none>",
    prg_name_field() and prg_name_field()() or "<none>",
    reqid_field()(),
    item_count_field()()
  )
  pktinfo.cols.info:set(info_msg)
end


DissectorTable.get("tcp.port"):add(default_settings.port, magicxpa_proto)
