-- Decompiled from: ReplicatedStorage.Modules.Component.init.spec
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return function() --[[ Line: 1 ]]
    local l__Parent__1 = require(script.Parent);
    local l__CollectionService__2 = game:GetService("CollectionService");
    local l__RunService__3 = game:GetService("RunService");
    local u1 = nil;
    local u8 = l__Parent__1.new({
        Tag = "__KnitTestComponent__",
        Ancestors = { workspace, game:GetService("Lighting") },
        Extensions = {
            {
                ShouldConstruct = function(_) --[[ Name: ShouldConstruct, Line 21 ]]
                    return true;
                end,
                Constructing = function(p2) --[[ Name: Constructing, Line 24 ]]
                    p2.Data = "a";
                    p2.DidHeartbeat = false;
                    p2.DidStepped = false;
                    p2.DidRenderStepped = false;
                end,
                Constructed = function(p3) --[[ Name: Constructed, Line 30 ]]
                    p3.Data = p3.Data .. "c";
                end,
                Starting = function(p4) --[[ Name: Starting, Line 33 ]]
                    p4.Data = p4.Data .. "d";
                end,
                Started = function(p5) --[[ Name: Started, Line 36 ]]
                    p5.Data = p5.Data .. "f";
                end,
                Stopping = function(p6) --[[ Name: Stopping, Line 39 ]]
                    p6.Data = p6.Data .. "g";
                end,
                Stopped = function(p7) --[[ Name: Stopped, Line 42 ]]
                    p7.Data = p7.Data .. "i";
                end
            }
        }
    });
    local u9 = l__Parent__1.new({
        Tag = "__KnitTestComponent__"
    });
    function u9.GetData(_) --[[ Line: 53 ]]
        return true;
    end;
    function u8.Construct(p10) --[[ Line: 57 ]]
        p10.Data = p10.Data .. "b";
    end;
    function u8.Start(p11) --[[ Line: 61 ]]
        -- upvalues: u9 (copy)
        p11.Another = p11:GetComponent(u9);
        p11.Data = p11.Data .. "e";
    end;
    function u8.Stop(p12) --[[ Line: 66 ]]
        p12.Data = p12.Data .. "h";
    end;
    function u8.HeartbeatUpdate(p13, _) --[[ Line: 70 ]]
        p13.DidHeartbeat = true;
    end;
    function u8.SteppedUpdate(p14, _) --[[ Line: 74 ]]
        p14.DidStepped = true;
    end;
    function u8.RenderSteppedUpdate(p15, _) --[[ Line: 78 ]]
        p15.DidRenderStepped = true;
    end;
    beforeAll(function() --[[ Line: 82 ]]
        -- upvalues: u1 (ref)
        u1 = Instance.new("Folder");
        u1.Name = "KnitComponentTest";
        u1.Archivable = false;
        u1.Parent = workspace;
    end);
    afterEach(function() --[[ Line: 89 ]]
        -- upvalues: u1 (ref)
        u1:ClearAllChildren();
    end);
    afterAll(function() --[[ Line: 93 ]]
        -- upvalues: u1 (ref), u8 (copy)
        u1:Destroy();
        u8:Destroy();
    end);
    describe("Component", function() --[[ Line: 98 ]]
        -- upvalues: u8 (copy), l__CollectionService__2 (copy), u1 (ref), l__RunService__3 (copy), l__Parent__1 (copy)
        it("should capture start and stop events", function() --[[ Line: 99 ]]
            -- upvalues: u8 (ref), l__CollectionService__2 (ref), u1 (ref)
            local u16 = 0;
            local u17 = 0;
            local v18 = u8.Started:Connect(function() --[[ Line: 102 ]]
                -- upvalues: u16 (ref)
                u16 = u16 + 1;
            end);
            local v19 = u8.Stopped:Connect(function() --[[ Line: 105 ]]
                -- upvalues: u17 (ref)
                u17 = u17 + 1;
            end);
            local v20 = Instance.new("Folder");
            l__CollectionService__2:AddTag(v20, "__KnitTestComponent__");
            v20.Name = "ComponentTest";
            v20.Archivable = false;
            v20.Parent = u1;
            task.wait();
            v20:Destroy();
            task.wait();
            v18:Disconnect();
            v19:Disconnect();
            expect(u16).to.equal(1);
            expect(u17).to.equal(1);
        end);
        it("should be able to get component from the instance", function() --[[ Line: 118 ]]
            -- upvalues: l__CollectionService__2 (ref), u1 (ref), u8 (ref)
            local v21 = Instance.new("Folder");
            l__CollectionService__2:AddTag(v21, "__KnitTestComponent__");
            v21.Name = "ComponentTest";
            v21.Archivable = false;
            v21.Parent = u1;
            task.wait();
            local v22 = u8:FromInstance(v21);
            expect(v22).to.be.ok();
        end);
        it("should be able to get all component instances existing", function() --[[ Line: 125 ]]
            -- upvalues: l__CollectionService__2 (ref), u1 (ref), u8 (ref)
            local v23 = table.create(3);
            local v24 = Instance.new("Folder");
            l__CollectionService__2:AddTag(v24, "__KnitTestComponent__");
            v24.Name = "ComponentTest";
            v24.Archivable = false;
            v24.Parent = u1;
            v23[1] = v24;
            local v25 = Instance.new("Folder");
            l__CollectionService__2:AddTag(v25, "__KnitTestComponent__");
            v25.Name = "ComponentTest";
            v25.Archivable = false;
            v25.Parent = u1;
            v23[2] = v25;
            local v26 = Instance.new("Folder");
            l__CollectionService__2:AddTag(v26, "__KnitTestComponent__");
            v26.Name = "ComponentTest";
            v26.Archivable = false;
            v26.Parent = u1;
            v23[3] = v26;
            task.wait();
            local v27 = u8:GetAll();
            expect(v27).to.be.a("table");
            expect(#v27).to.equal(3);
            for _, v28 in ipairs(v27) do
                expect(table.find(v23, v28.Instance)).to.be.ok();
            end;
        end);
        it("should call lifecycle methods and extension functions", function() --[[ Line: 141 ]]
            -- upvalues: l__CollectionService__2 (ref), u1 (ref), u8 (ref), l__RunService__3 (ref)
            local v29 = Instance.new("Folder");
            l__CollectionService__2:AddTag(v29, "__KnitTestComponent__");
            v29.Name = "ComponentTest";
            v29.Archivable = false;
            v29.Parent = u1;
            task.wait(0.2);
            local v30 = u8:FromInstance(v29);
            expect(v30).to.be.ok();
            expect(v30.Data).to.equal("abcdef");
            expect(v30.DidHeartbeat).to.equal(true);
            expect(v30.DidStepped).to.equal(l__RunService__3:IsRunning());
            expect(v30.DidRenderStepped).to.never.equal(true);
            v29:Destroy();
            task.wait();
            expect(v30.Data).to.equal("abcdefghi");
        end);
        it("should get another component linked to the same instance", function() --[[ Line: 155 ]]
            -- upvalues: l__CollectionService__2 (ref), u1 (ref), u8 (ref)
            local v31 = Instance.new("Folder");
            l__CollectionService__2:AddTag(v31, "__KnitTestComponent__");
            v31.Name = "ComponentTest";
            v31.Archivable = false;
            v31.Parent = u1;
            task.wait();
            local v32 = u8:FromInstance(v31);
            expect(v32).to.be.ok();
            expect(v32.Another).to.be.ok();
            expect(v32.Another:GetData()).to.equal(true);
        end);
        it("should use extension to decide whether or not to construct", function() --[[ Line: 164 ]]
            -- upvalues: l__Parent__1 (ref), l__CollectionService__2 (ref), u1 (ref)
            local u33 = {
                c = true
            };
            function u33.ShouldConstruct(_) --[[ Line: 166 ]]
                -- upvalues: u33 (copy)
                return u33.c;
            end;
            local u34 = {
                c = true
            };
            function u34.ShouldConstruct(_) --[[ Line: 171 ]]
                -- upvalues: u34 (copy)
                return u34.c;
            end;
            local u35 = {
                c = true
            };
            function u35.ShouldConstruct(_) --[[ Line: 176 ]]
                -- upvalues: u35 (copy)
                return u35.c;
            end;
            local v36 = l__Parent__1.new({
                Tag = "__KnitTestComponent__",
                Extensions = { u33 }
            });
            local v37 = l__Parent__1.new({
                Tag = "__KnitTestComponent__",
                Extensions = { u33, u34 }
            });
            local v38 = l__Parent__1.new({
                Tag = "__KnitTestComponent__",
                Extensions = { u33, u34, u35 }
            });
            u33.c = true;
            u34.c = true;
            u35.c = true;
            local v39 = Instance.new("Folder");
            l__CollectionService__2:AddTag(v39, "__KnitTestComponent__");
            v39.Name = "ComponentTest";
            v39.Archivable = false;
            v39.Parent = u1;
            task.wait();
            local v40 = v36:FromInstance(v39);
            expect(v40).to.be.ok();
            local v41 = v37:FromInstance(v39);
            expect(v41).to.be.ok();
            local v42 = v38:FromInstance(v39);
            expect(v42).to.be.ok();
            u33.c = false;
            u34.c = false;
            u35.c = false;
            local v43 = Instance.new("Folder");
            l__CollectionService__2:AddTag(v43, "__KnitTestComponent__");
            v43.Name = "ComponentTest";
            v43.Archivable = false;
            v43.Parent = u1;
            task.wait();
            local v44 = v36:FromInstance(v43);
            expect(v44).to.never.be.ok();
            local v45 = v37:FromInstance(v43);
            expect(v45).to.never.be.ok();
            local v46 = v38:FromInstance(v43);
            expect(v46).to.never.be.ok();
            u33.c = true;
            u34.c = false;
            u35.c = true;
            local v47 = Instance.new("Folder");
            l__CollectionService__2:AddTag(v47, "__KnitTestComponent__");
            v47.Name = "ComponentTest";
            v47.Archivable = false;
            v47.Parent = u1;
            task.wait();
            local v48 = v36:FromInstance(v47);
            expect(v48).to.be.ok();
            local v49 = v37:FromInstance(v47);
            expect(v49).to.never.be.ok();
            local v50 = v38:FromInstance(v47);
            expect(v50).to.never.be.ok();
            u33.c = false;
            u34.c = false;
            u35.c = true;
            local v51 = Instance.new("Folder");
            l__CollectionService__2:AddTag(v51, "__KnitTestComponent__");
            v51.Name = "ComponentTest";
            v51.Archivable = false;
            v51.Parent = u1;
            task.wait();
            local v52 = v36:FromInstance(v51);
            expect(v52).to.never.be.ok();
            local v53 = v37:FromInstance(v51);
            expect(v53).to.never.be.ok();
            local v54 = v38:FromInstance(v51);
            expect(v54).to.never.be.ok();
        end);
        it("should decide whether or not to use extend", function() --[[ Line: 224 ]]
            -- upvalues: l__Parent__1 (ref), l__CollectionService__2 (ref), u1 (ref)
            local u55 = {
                extend = true
            };
            function u55.ShouldExtend(_) --[[ Line: 226 ]]
                -- upvalues: u55 (copy)
                return u55.extend;
            end;
            function u55.Constructing(p56) --[[ Line: 229 ]]
                p56.E1 = true;
            end;
            local u57 = {
                extend = true
            };
            function u57.ShouldExtend(_) --[[ Line: 234 ]]
                -- upvalues: u57 (copy)
                return u57.extend;
            end;
            function u57.Constructing(p58) --[[ Line: 237 ]]
                p58.E2 = true;
            end;
            local u59 = l__Parent__1.new({
                Tag = "__KnitTestComponent__",
                Extensions = { u55, u57 }
            });
            local function v64(p60, p61) --[[ Line: 243 ]]
                -- upvalues: u55 (copy), u57 (copy), l__CollectionService__2 (ref), u1 (ref), u59 (copy)
                u55.extend = p60;
                u57.extend = p61;
                local v62 = Instance.new("Folder");
                l__CollectionService__2:AddTag(v62, "__KnitTestComponent__");
                v62.Name = "ComponentTest";
                v62.Archivable = false;
                v62.Parent = u1;
                task.wait();
                local v63 = u59:FromInstance(v62);
                expect(v63).to.be.ok();
                if p60 then
                    expect(v63.E1).to.equal(true);
                else
                    expect(v63.E1).to.never.be.ok();
                end;
                if p61 then
                    expect(v63.E2).to.equal(true);
                else
                    expect(v63.E2).to.never.be.ok();
                end;
            end;
            v64(true, true);
            v64(false, false);
            v64(true, false);
            v64(false, true);
        end);
        it("should allow yielding within construct", function() --[[ Line: 268 ]]
            -- upvalues: l__Parent__1 (ref), l__CollectionService__2 (ref)
            local v65 = l__Parent__1.new({
                Tag = "CustomTag"
            });
            local u66 = 0;
            function v65.Construct(_) --[[ Line: 275 ]]
                -- upvalues: u66 (ref)
                u66 = u66 + 1;
                task.wait(0.5);
            end;
            local v67 = Instance.new("Part");
            v67.Anchored = true;
            v67.Parent = game:GetService("ReplicatedStorage");
            l__CollectionService__2:AddTag(v67, "CustomTag");
            local v68 = v67:Clone();
            v68.Parent = workspace;
            task.wait(0.6);
            expect(u66).to.equal(1);
            v67:Destroy();
            v68:Destroy();
        end);
        it("should wait for instance", function() --[[ Line: 294 ]]
            -- upvalues: l__CollectionService__2 (ref), u8 (ref)
            local u69 = Instance.new("Part");
            u69.Anchored = true;
            u69.Parent = workspace;
            task.delay(0.1, function() --[[ Line: 298 ]]
                -- upvalues: l__CollectionService__2 (ref), u69 (copy)
                l__CollectionService__2:AddTag(u69, "__KnitTestComponent__");
            end);
            local v70, v71 = u8:WaitForInstance(u69):timeout(1):await();
            expect(v70).to.equal(true);
            expect(v71).to.be.a("table");
            expect(v71.Instance).to.equal(u69);
            u69:Destroy();
        end);
    end);
end;
