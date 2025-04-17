import json
from django.core.management.base import BaseCommand
from shopper.models import Region

class Command(BaseCommand):
    help = 'Import regions from JSON file'

    def handle(self, *args, **options):
        with open('C:/Users/zhang/Desktop/project/server/logistics/management/commands/regions.json','r', encoding='utf-8') as f:
            data = json.load(f)
        
        regions = []
        for item in data:
            regions.append(Region(
                id=item['id'],
                name=item['name'],
                level=item['level'],
                parent_id=item['parent']
            ))
        
        Region.objects.bulk_create(regions)
        self.stdout.write(self.style.SUCCESS(f'Successfully imported {len(regions)} regions'))
