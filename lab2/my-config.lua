-- Initialize tables
local tables = {}

-- Table for 'natural' nodes

-- tables.natural_nodes = osm2pgsql.define_node_table(
--     'natural_nodes',
--     {
--         { column = 'osm_id', type = 'bigint', create_only = true },
--         { column = 'natural', type = 'text' },
--         { column = 'tags', type = 'hstore' },
--         { column = 'geom', type = 'geometry', projection = 4326 },
--     }
-- )

tables.natural_nodes = osm2pgsql.define_table{
    name = 'natural_nodes',
    ids = { type = 'any', id_column = 'osm_id' },
    columns = {
        { column = 'natural', type = 'text' },
        { column = 'tags', type = 'hstore' },
        { column = 'geom', type = 'geometry', projection = 4326 },
    }
}



-- Node processing function
function osm2pgsql.process_node(object)
    -- Check if node has the 'natural' tag
    if object.tags.natural then
        tables.natural_nodes:insert({
            osm_id = object.id,
            natural = object.tags.natural,
            geom = object:as_point()
        })
    end
end


function checkTags(object)
    local tags = object.tags
    if not tags then
        return false
    end-- Kryteria filtrowania z poprzedniego ćwiczenia


    if tags.amenity == 'university' then
        return true
    end

    if tags.landuse == 'residential' and tags.name == 'Miasteczko Studenckie AGH' then
        return true
    end

    if tags.building == 'university' or tags.building == 'educational' then
        return true
    end

    if tags.amenity == 'pub' or tags.amenity == 'bar' then
        return true
    end

    if tags.amenity == 'toilets' then
        return true
    end

    return false
end

function osm2pgsql.process_node(object)
    if checkTags(object) then
        tables.natural_nodes:insert({
            osm_id = object.id,
            name = object.tags.name,
            tags = object.tags,
            geom = object:as_point()
        })
    end
end

function osm2pgsql.process_way(object)
    if checkTags(object) then
        if object.is_closed then
            tables.natural_nodes:insert({
                osm_id = object.id,
                name = object.tags.name,
                tags = object.tags,
                geom = object:as_polygon()
            })
        else
            tables.natural_nodes:insert({
                osm_id = object.id,
                name = object.tags.name,
                tags = object.tags,
                geom = object:as_linestring()
            })
        end
    end
end

function osm2pgsql.process_relation(object)
    if checkTags(object) then
        if object.tags.type == 'multipolygon' or object.tags.type == 'boundary' then
            tables.natural_nodes:insert({
                osm_id = object.id,
                name = object.tags.name,
                tags = object.tags,
                geom = object:as_multipolygon()
            })
        end
    end
end