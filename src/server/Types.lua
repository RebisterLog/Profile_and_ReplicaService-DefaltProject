export type IProfile = {
    Data: table,
    MetaData: {
        ProfileCreateTime: number,
        SessionLoadCount: number,
        ActiveSession: {
            place_id: number,
            game_job_id: number,
        } | nil,
        MetaTags: {
            [string]: any,
        },
        MetaTagsLatest: {
            [string]: any,
        },
    },
    MetaTagsUpdated: RBXScriptSignal,
    RobloxMetaData: table,
    UserIds: {
        [number]: number,
    },
    KeyInfo: DataStoreKeyInfo,
    KeyInfoUpdated: RBXScriptSignal,
    GlobalUpdates: {},
    IsActive: () -> boolean,
    GetMetaTag: (tag_name: string) -> any,
    Reconcile: () -> nil,
    ListenToRelease: (listener: (place_id: number | nil, game_job_id: number | nil) -> nil) -> RBXScriptConnection,
    Release: () -> nil,
    ListenToHopReady: (listener: () -> nil) -> RBXScriptConnection,
    AddUserId: (user_id: number) -> nil,
    RemoveUserId: (user_id: number) -> nil,
    Identify: () -> string,
    SetMetaTag: (tag_name: string, value: any) -> nil,
    Save: () -> nil,
    ClearGlobalUpdates: () -> nil,
    OverwriteAsync: () -> nil,
}

export type IReplica = {
    Data: table,
    Id: number,
    Class: string,
    Tags: table,
    Parent: IReplica,
    Children: table,
    
    SetValue: (self: IReplica, path: string, value: any) -> nil,
    SetValues: (self: IReplica, path: string, values: table) -> nil,
    
    ArrayInsert: (self: IReplica, path: string, value: any) -> number,
    ArraySet: (self: IReplica, path: string, index: number, value: any) -> nil,
    ArrayRemove: (self: IReplica, path: string, index: number) -> any,
    
    Write: (self: IReplica, function_name: string, ...any) -> any,
    
    ConnectOnServerEvent: (self: IReplica, listener: (player: any, ...any) -> nil) -> any,
    FireClient: (self: IReplica, player: any, ...any) -> nil,
    FireAllClients: (self: IReplica, ...any) -> nil,
    
    SetParent: (self: IReplica, replica: IReplica) -> nil,
    
    ReplicateFor: (self: IReplica, target: any) -> nil,
    DestroyFor: (self: IReplica, target: any) -> nil,
    
    Identify: (self: IReplica) -> string,
    
    IsActive: (self: IReplica) -> boolean,
    
    AddCleanupTask: (self: IReplica, task: () -> any | any | {}) -> nil,
    RemoveCleanupTask: (self: IReplica, task:  () -> any | any | {}) -> nil,
    
    Destroy: (self: IReplica) -> nil,
}

export type IMaid = {
    AddCleanupTask: (task: any) -> (...any) -> nil;
    RemoveCleanupTask: (task: any) -> nil;
    CleanupOfOne: (task: any, ...any) -> nil;
    Cleanup: (...any) -> nil;
}

export type IPlayerProfile = {
    Profile: IProfile,
    Replica: IReplica,
    Instance: Player,
    Maid: IMaid,

    IsActive: (self: IPlayerProfile) -> boolean,
    Get: (self: IPlayerProfile, player: Player) -> IPlayerProfile,
    Remove: (self: IPlayerProfile, player: Player) -> nil,
}

export type ICharacterComponent = {
    Instance: Model,
    Player: Player?,
    Maid: IMaid,

    Init: (self: ICharacterComponent, character: Model) -> nil,
    Destroy: (self: ICharacterComponent) -> nil,
}

return nil