require 'rails_helper'
#  rspec --tag 'service'
RSpec.describe ServicePresenter, type: :presenter, service: true do
  let(:service) { build(:service) }
  subject(:service_presenter) { ServicePresenter.new(object: service, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:name).to(:service) }
  end

  describe 'standard service' do
    it 'returns the linked name' do
      expect(service_presenter.linked_name).to eq(link_to service.name, service)
    end

    it 'returns the linked department' do
      expect(service_presenter.linked_department).to eq(link_to service.department.name, service.department)
    end

    it 'returns the department' do
      expect(service_presenter.department).to eq(service.department)
    end

    it 'returns the linked audience' do
      expect(service_presenter.linked_audience).to eq(link_to service.department.audience.name, service.department.audience)
    end

    it 'returns the department name' do
      expect(service_presenter.department_name).to eq(service.department.name)
    end

    it 'returns the summary - html formatted' do
      expect(service_presenter.summary).to eq(simple_format service.summary)
    end

    it 'returns the content html' do
      expect(service_presenter.content).to eq(raw service.content)
    end

    it 'returns the specialisms html' do
      expect(service_presenter.specialisms).to eq(raw service.specialisms)
    end
  end

  describe 'images' do
    describe 'no image' do
      it 'show_image should return nil' do
        expect(service_presenter.show_image).to eq(nil)
      end
      it 'index_image should return nil' do
        expect(service_presenter.index_image).to eq(nil)
      end
    end

    describe 'has image' do
      let(:service) { build(:service_with_image) }
      subject(:service_presenter) { ServicePresenter.new(object: service, view_template: view) }

      it 'show_image should not return nil' do
        expect(service_presenter.show_image(alt: service.name)).to eq(image_tag(service.image.show, alt: service.name))
      end

      it 'index image should not return nil' do
        expect(service_presenter.index_image(alt: service.name)).to eq(image_tag(service.image.index, alt: service.name))
      end
    end
  end
end
