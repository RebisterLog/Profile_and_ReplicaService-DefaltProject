
export type IProfile = {
    Data: {any},
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
    RobloxMetaData: {any},
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

export type IProfileTemplate = {
    Spawnpoints: {string},
}

export type IDynamicTemplate = {}

export type IReplica = {
    Data: IReplicaData,
    Id: number,
    Class: string,
    Tags: {any},
    Parent: IReplica,
    Children: {any},
    
    SetValue: (self: IReplica, path: {string} | string, value: any) -> nil,
    SetValues: (self: IReplica, path: {string} | string, values: {any}) -> nil,
    
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
    GiveTask: (self: IMaid, task: any) -> (...any) -> nil;
    GivePromise: (self: IMaid, task: any) -> (...any) -> nil;
    DoCleaning: (self: IMaid) -> nil;
}

export type IReplicaData = IProfileTemplate & IDynamicTemplate

export type Event <args...> = {
    Connect: (self: Event<args...>, func: (args...) -> ...any) -> nil,
    Disconnect: (self: Event<args...>, func: (args...) -> ...any) -> nil,
    Destroy: (self: Event<args...>) -> nil,
    Wait: (self: Event<args...>, timeout: number?) -> nil,
    Once: (self: Event<args...>, func: (args...) -> ...any) -> nil,
    Single: (self: Event<args...>, func: (args...) -> ...any) -> nil,
    Fire: (self: Event<args...>, ...any) -> nil,
}

export type Remote = {
	Connect: (self: Remote, func: (...any) -> ...any) -> nil,
	Disconnent: (self: Remote, func: (...any) -> ...any) -> nil,
	Destroy: (self: Remote) -> nil,
	Wait: (self: Remote, timeout: number?) -> nil,
	Once: (self: Remote, func: (...any) -> ...any) -> nil,
	Single: (self: Remote, func: (...any) -> ...any) -> nil,
	
	FireAllClients: (self: Remote, ...any) -> nil,
	FireClient: (self: Remote, client: Player, ...any) -> nil,
	FireServer: (self: Remote, ...any) -> nil,
	FireClientsInRadius: (self: Remote, origin: Vector3, radius: number, ...any) -> nil,
}

export type Unreliable = {
	Connect: (self: Unreliable, func: (...any) -> ...any) -> nil,
	Disconnent: (self: Unreliable, func: (...any) -> ...any) -> nil,
	Destroy: (self: Unreliable) -> nil,
	Wait: (self: Unreliable, timeout: number?) -> nil,
	Once: (self: Unreliable, func: (...any) -> ...any) -> nil,
	Single: (self: Unreliable, func: (...any) -> ...any) -> nil,

	FireAllClients: (self: Unreliable, ...any) -> nil,
	FireClient: (self: Unreliable, client: Player, ...any) -> nil,
	FireServer: (self: Unreliable, ...any) -> nil,
	FireClientsInRadius: (self: Unreliable, origin: Vector3, radius: number, ...any) -> nil,
}

export type ICharacterComponent = {
    Instance: Model,
    Player: Player?,
    Maid: IMaid,

    Init: (self: ICharacterComponent, character: Model) -> nil,
    Destroy: (self: ICharacterComponent) -> nil,
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

return nil