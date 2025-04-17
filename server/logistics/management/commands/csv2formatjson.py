import csv
import json
from collections import defaultdict

def process_data():
    # 存储最终结果
    regions = []
    id_counter = 1
    
    # 第一遍：处理省份数据
    province_map = {}  # {原始code: 新id}
    with open('province.csv', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            regions.append({
                "id": id_counter,
                "name": row['name'],
                "level": 1,
                "parent": None
            })
            province_map[row['code']] = id_counter
            id_counter += 1
    
    # 第二遍：处理城市数据
    city_map = {}  # {原始code: 新id}
    with open('city.csv', encoding='utf-8') as f:
        reader = csv.DictReader(f, fieldnames=['code', 'name', 'province_code'])
        for row in reader:
            # 获取对应的省份ID
            province_id = province_map.get(row['province_code'])
            if province_id is None:
                continue  # 跳过无效数据
            
            regions.append({
                "id": id_counter,
                "name": row['name'],
                "level": 2,
                "parent": province_id
            })
            city_map[row['code']] = id_counter
            id_counter += 1
    
    # 第三遍：处理区县数据
    with open('county.csv', encoding='utf-8') as f:
        reader = csv.DictReader(f, fieldnames=['code', 'name', 'city_code'])
        for row in reader:
            # 获取对应的城市ID
            city_id = city_map.get(row['city_code'])
            if city_id is None:
                continue  # 跳过无效数据
            
            regions.append({
                "id": id_counter,
                "name": row['name'],
                "level": 3,
                "parent": city_id
            })
            id_counter += 1
    
    # 保存为JSON文件
    with open('regions.json', 'w', encoding='utf-8') as f:
        json.dump(regions, f, ensure_ascii=False, indent=2)
    
    print(f"转换完成，共处理 {len(regions)} 条记录")
    print("结果已保存到 regions.json")

if __name__ == '__main__':
    process_data()
