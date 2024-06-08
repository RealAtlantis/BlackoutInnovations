local AnimationManager = {}

function AnimationManager:CreateAnimations(animationData, humanoid)
    local animationTracks = {}
    for name, id in pairs(animationData) do
        local animation = Instance.new("Animation")
        animation.Parent = humanoid
        animation.Name = name
        animation.AnimationId = id
        local animationTrack = humanoid:LoadAnimation(animation)
        animationTracks[name] = animationTrack
    end
    return animationTracks
end

function AnimationManager:PlayAnimation(animationTracks, animationName, ...)
    local track = animationTracks[animationName]
    if track and not track.IsPlaying then
        track:Play(...)
    end
end

function AnimationManager:StopAnimation(animationTracks, animationName, ...)
    local track = animationTracks[animationName]
    if track then
        track:Stop(...)
    end
end

function AnimationManager:StopAllAnimationsInTracks(animationTracks, ...)
    for _, track in pairs(animationTracks) do
        track:Stop(...)
    end
end

function AnimationManager:StopAllHumanoidAnimations(humanoid, ...)
    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        track:Stop(...)
    end
end

return AnimationManager
