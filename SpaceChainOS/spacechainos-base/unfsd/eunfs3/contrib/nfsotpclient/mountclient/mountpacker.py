# Generated by rpcgen.py at Mon Mar  8 11:09:57 2004

import rpc
import mounttypes
import mountconstants
import xdrlib

__all__ = ['MOUNTPacker', 'MOUNTUnpacker']

class MOUNTPacker(rpc.Packer):
    def __init__(self, ncl):
        xdrlib.Packer.__init__(self)
        self.ncl = ncl

    pack_hyper = rpc.Packer.pack_hyper

    pack_string = rpc.Packer.pack_string

    pack_enum = rpc.Packer.pack_enum

    pack_opaque = rpc.Packer.pack_opaque

    pack_int = rpc.Packer.pack_int

    pack_double = rpc.Packer.pack_double

    pack_float = rpc.Packer.pack_float

    pack_unsigned = rpc.Packer.pack_uint

    pack_quadruple = rpc.Packer.pack_double

    pack_bool = rpc.Packer.pack_bool

    pack_unsigned_int = rpc.Packer.pack_uint

    pack_unsigned_hyper = rpc.Packer.pack_uhyper

    def pack_fhandle2(self, data):
        self.pack_fopaque(mountconstants.FHSIZE2, data)
        
    def pack_fhandle3(self, data):
        self.pack_opaque(data)
        
    def pack_dirpath(self, data):
        self.pack_string(data)
        
    def pack_name(self, data):
        self.pack_string(data)
        
    pack_mountstat3 = pack_enum

    def pack_mountlist(self, data):
        mounttypes.pack_objarray(self, data)
        
    def pack_groups(self, data):
        mounttypes.pack_objarray(self, data)
        
    def pack_exports(self, data):
        mounttypes.pack_objarray(self, data)
        
class MOUNTUnpacker(rpc.Unpacker):
    def __init__(self, ncl, data=''):
        xdrlib.Unpacker.__init__(self, data)
        self.ncl = ncl

    unpack_hyper = rpc.Unpacker.unpack_hyper

    unpack_string = rpc.Unpacker.unpack_string

    unpack_enum = rpc.Unpacker.unpack_enum

    unpack_opaque = rpc.Unpacker.unpack_opaque

    unpack_int = rpc.Unpacker.unpack_int

    unpack_double = rpc.Unpacker.unpack_double

    unpack_float = rpc.Unpacker.unpack_float

    unpack_unsigned = rpc.Unpacker.unpack_uint

    unpack_quadruple = rpc.Unpacker.unpack_double

    unpack_bool = rpc.Unpacker.unpack_bool

    unpack_unsigned_int = rpc.Unpacker.unpack_uint

    unpack_unsigned_hyper = rpc.Unpacker.unpack_uhyper

    def unpack_fhandle2(self):
        return self.unpack_fopaque(mountconstants.FHSIZE2)
        
    def unpack_fhandle3(self):
        return self.unpack_opaque()
        
    def unpack_dirpath(self):
        return self.unpack_string()
        
    def unpack_name(self):
        return self.unpack_string()
        
    unpack_mountstat3 = unpack_enum

    def unpack_mountlist(self):
        return mounttypes.unpack_objarray(self.ncl, mounttypes.mountbody)
        
    def unpack_groups(self):
        return mounttypes.unpack_objarray(self.ncl, mounttypes.groupnode)
        
    def unpack_exports(self):
        return mounttypes.unpack_objarray(self.ncl, mounttypes.exportnode)
        